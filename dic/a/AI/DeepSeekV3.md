# DeepSeek V3 파일 구성 해설

- source : https://github.com/deepseek-ai/DeepSeek-V3
    - 참고로 DeepSeek R1의 레포지토리에는 소스가 전혀 없고, V3를 베이스로 한다고 되어 있음.

## File Structure

주요 파일만 정리함.

### `/inference/model.py`

1. ModelArgs

    모델의 하이퍼파라미터를 정의하는 데이터 클래스.
    배치 크기, 시퀀스 길이, 차원 크기, MoE 설정 등의 다양한 설정값을 포함.

2. ParallelEmbedding

    대규모 모델에서 분산 학습을 위한 병렬 임베딩을 제공.

3. Linear

    저비트 연산 (FP8/BF16) 을 지원하는 선형 변환 연산.

4. ColumnParallelLinear & RowParallelLinear

    데이터 병렬 학습을 지원하는 선형 변환 연산.
    ColumnParallelLinear: 출력 차원을 병렬로 분할.
    RowParallelLinear: 입력 차원을 병렬로 분할.

5. RMSNorm

    LayerNorm 대신 Root Mean Square Normalization (RMSNorm) 사용.

6. MLA (Multi-Headed Attention Layer)

    표준 Transformer Attention을 개선한 MLA 구현.
    LoRA 기법을 활용하여 Query/Key/Value를 Low-rank 방식으로 압축.

7. MoE (Mixture-of-Experts)

    여러 개의 전문가 네트워크 (Expert Layer) 를 사용하여 성능을 최적화.
    Gate를 사용해 입력을 특정 전문가에게 라우팅.

8. Block

    Transformer의 기본 블록 (Attention + MoE/MLP).
    MLA + MoE(또는 MLP)를 조합하여 하나의 Transformer Layer를 구성.

9. Transformer
 
    전체 Transformer 모델을 정의.
    병렬 임베딩 + 여러 개의 Transformer 블록 + 최종 출력 레이어 포함.


### `/inference/kernel.py`
kernel.py 파일은 DeepSeek에서 사용되는 GPU 가속 커널을 구현한 코드입니다. 주요 내용은 다음과 같습니다:

1. 활성화(activation) quantization:

    act_quant_kernel와 act_quant 함수는 입력 텐서를 block 단위로 quantize합니다.
    각 블록에서 입력 텐서의 절대값 최댓값을 기반으로 scaling factor를 계산하고, 이를 사용해 텐서를 quantize하여 저장합니다. 

2. 가중치(weight) dequantization:

    weight_dequant_kernel와 weight_dequant 함수는 quantized된 가중치 텐서를 복원(dequantize)합니다.
    저장된 scaling factor를 사용해 원래의 값으로 복원하는 방식으로 구현되어 있습니다. 

3. FP8 GEMM 연산:

    fp8_gemm_kernel와 fp8_gemm 함수는 FP8 precision을 활용한 행렬 곱셈(GEMM)을 수행합니다.
    다양한 블록 크기 설정과 autotuning 기능을 사용해 최적의 성능을 도출하도록 구성되어 있습니다. 
    전체적으로, 이 코드는 트리톤(Triton) 라이브러리를 이용하여 GPU에서 효율적인 연산을 수행하도록 최적화된 커널들을 제공하며, DeepSeek의 연산 성능을 향상시키기 위한 핵심 요소들을 담고 있습니다.

### `/inference/generate.py`

generate.py 파일은 Transformer 모델을 사용하여 텍스트를 생성하는 기능을 제공하는 스크립트입니다. 주요 구성 요소는 다음과 같습니다:

1. 토큰 샘플링 함수(sample):

    logits를 temperature로 스케일링한 후 softmax를 적용하여 확률 분포를 만든 뒤, 노이즈를 추가하여 argmax로 다음 토큰을 선택합니다. 

2. 토큰 생성 함수(generate):

    주어진 프롬프트 토큰(prompt_tokens)을 기반으로 최대 max_new_tokens만큼 새로운 토큰을 순차적으로 생성합니다.
    입력 프롬프트를 먼저 tokens 텐서에 초기화한 뒤, 모델의 forward 함수를 이용하여 현재까지 생성된 토큰들을 입력으로 받아 logits를 계산합니다.
    온도(temperature) 값에 따라 샘플링 또는 argmax 선택을 하며, EOS 토큰이 등장하면 생성 과정을 종료합니다.
    최종적으로 프롬프트 이후의 생성된 토큰 리스트를 반환합니다. 

3. 메인 함수(main):

    모델 체크포인트와 설정 파일(config)을 읽어들여 Transformer 모델과 ModelArgs 객체를 생성합니다.
    분산 학습 환경을 지원하기 위해 world_size, rank, local_rank 등의 환경변수를 확인하고 NCCL 백엔드를 초기화합니다.
    safetensors 라이브러리를 이용해 모델 파라미터를 로드하며, Hugging Face의 AutoTokenizer를 사용하여 토크나이저를 초기화합니다.
    인터랙티브 모드와 배치 처리 모드를 모두 지원합니다.
    인터랙티브 모드에서는 사용자 입력을 받아 채팅 형식으로 텍스트를 생성하며, "/exit"나 "/clear" 같은 명령어도 처리합니다.
    배치 모드에서는 입력 파일에 있는 프롬프트들을 읽어들여 한 번에 여러 시퀀스에 대해 생성 결과를 출력합니다.
    생성된 텍스트는 토크나이저를 통해 디코딩되어 출력됩니다. 

4. 명령행 인터페이스:

    ArgumentParser를 사용하여 --ckpt-path, --config, --input-file, --interactive, --max-new-tokens, --temperature 등의 인자를 받아 실행 시 옵션을 지정할 수 있도록 되어 있습니다.
    전체적으로 generate.py 파일은 Transformer 모델을 이용한 텍스트 생성 파이프라인을 구성하며, 분산 환경 및 인터랙티브/배치 모드 지원을 통해 다양한 사용 사례에 대응할 수 있도록 설계되어 있습니다.

소개 논문에는 [PRO, GPRO](https://github.com/LowyShin/KnowledgeBase/blob/master/dic/a/AI/PPO_DPO_KTO_GRPO_Comparison.md) 를 통한 [KL확산(Kullback-Leibler Divergence)](https://github.com/LowyShin/KnowledgeBase/blob/master/dic/a/AI/Kullback-Leibler.md) 처리에 대해 집중적으로 다루었으나 
이에 대한 내용이 없음. 
