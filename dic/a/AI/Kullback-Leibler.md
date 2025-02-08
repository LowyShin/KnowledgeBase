### **KL (Kullback-Leibler) Divergence란?**
KL 발산(Kullback-Leibler Divergence, KL-divergence)은 **두 확률 분포 간 차이를 측정하는 지표**입니다. 주로 확률 모델을 학습할 때 기존 분포(참조 모델)와 새로운 분포(학습된 모델) 간의 차이를 조정하는 데 사용됩니다.

---

## 🔹 **1. KL의 수학적 정의**
KL-divergence는 다음과 같이 정의됩니다.

\[
D_{KL}(P || Q) = \sum P(x) \log \frac{P(x)}{Q(x)}
\]

여기서:
- \( P(x) \) : 실제 데이터(또는 기존 모델)의 확률 분포
- \( Q(x) \) : 학습 중인 모델의 확률 분포

KL-divergence 값이 **작을수록 두 분포가 유사**하며, 값이 클수록 차이가 크다는 의미입니다.

---

## 🔹 **2. KL-divergence의 직관적 의미**
- KL-divergence는 **"기존 모델이 예측한 분포(P)를 기준으로, 새로운 모델(Q)이 얼마나 다른지를 측정"** 합니다.
- 한마디로 **새 모델이 기존 모델에서 얼마나 벗어났는지를 측정하는 거리(metric) 같은 역할**을 합니다.

✅ **KL이 작은 경우** → 기존 모델과 유사한 출력을 생성함  
❌ **KL이 큰 경우** → 기존 모델과 차이가 커짐 (예측이 크게 바뀜)

---

## 🔹 **3. LLM과 Transformer에서 KL-divergence 사용**
LLM (Large Language Models) 및 Transformer 기반 모델에서 KL-divergence는 **모델의 출력을 기존 모델과 비교하면서 학습을 제어하는 역할**을 합니다.

### **(1) PPO (Proximal Policy Optimization)에서 KL 사용**
- **RLHF (Reinforcement Learning with Human Feedback)에서 사용**
- LLM이 사용자 친화적인 응답을 학습할 때, 기존 모델과 너무 다르게 학습되지 않도록 **KL 제약을 추가**.
- 특정 KL 패널티를 추가하여 모델이 급격하게 변화하는 것을 방지함.

✅ **왜 필요할까?**
- 보상 모델만 최적화하면 모델이 원래 GPT-4, GPT-3.5의 성질을 잃어버릴 수 있음.
- **PPO에서는 KL-divergence를 통해 모델이 기존 LLM과 지나치게 달라지지 않도록 조정함**.

📌 **수식**
\[
L = R - \beta D_{KL}(\pi_{\theta} || \pi_{old})
\]
- \( R \): 보상 함수
- \( D_{KL}(\pi_{\theta} || \pi_{old}) \): 새 정책(\(\pi_{\theta}\))과 기존 정책(\(\pi_{old}\)) 간 KL-divergence
- \( \beta \): KL 가중치 (KL penalty)

---

### **(2) DPO (Direct Preference Optimization)에서 KL 사용**
- DPO는 KL을 **직접 계산하지 않고, 암시적으로 보존**.
- PPO처럼 명확한 KL 패널티를 두지는 않지만, 기존 모델을 유지하는 방향으로 학습이 진행됨.

✅ **PPO와 비교하면?**
- **PPO**는 KL을 직접 패널티로 사용하여 기존 모델과의 차이를 제한함.
- **DPO**는 보상 모델 없이도 암시적으로 KL을 유지하면서 최적화됨.

---

### **(3) KTO (KL-preference Transfer Optimization)에서 KL 사용**
- **KTO는 기존 모델과의 KL-divergence를 강하게 유지**하면서 선호 학습을 수행.
- PPO와 유사하지만, **KL 제약을 더 강하게 두어 기존 모델과 크게 벗어나지 않도록 제한**.

✅ **왜 필요할까?**
- 기존 모델의 성질을 보존하면서, 선호 최적화를 진행하고 싶을 때.
- **KTO는 기존 모델이 가진 특성을 유지하면서도 선호 데이터를 반영하는 방법**.

📌 **수식**
\[
L = \log \pi_{\theta}(y | x) - \lambda D_{KL}(\pi_{\theta} || \pi_{old})
\]
- \( \lambda \) 값이 크면 기존 모델과 차이를 최소화 (안정적인 학습 가능)
- 기존 GPT-4, Claude 모델을 크게 변형하지 않고, 사용자 선호를 반영하고 싶을 때 사용됨.

---

## 🔹 **4. KL을 활용한 최적화 방법 비교**
| 알고리즘 | KL 활용 방식 | KL 제약 수준 | 특징 |
|----------|-------------|------------|------|
| **PPO** | KL 패널티를 직접 추가 | 🔵 중간~강함 | 기존 모델과 너무 다르게 학습되지 않도록 조절 |
| **DPO** | KL을 직접 사용하지 않지만 암시적으로 보존 | 🟢 약함 | RL 없이 선호 최적화, KL을 직접 계산하지 않음 |
| **KTO** | KL을 강하게 유지하며 선호 최적화 | 🔴 매우 강함 | 기존 모델과 차이를 최소화하면서 선호 반영 |
| **GRPO** | KL을 직접 사용하지 않고 Gradient Regularization 적용 | ⚫ 없음 | KL 없이도 안정적인 최적화 가능 |

---

## 🔹 **5. 결론**
KL-divergence는 **LLM 및 Transformer 모델에서 기존 모델과 새로운 모델 간의 차이를 측정하는 중요한 지표**입니다.

- **PPO**: KL을 직접 패널티로 활용하여 정책 최적화 (ChatGPT RLHF 과정)
- **DPO**: KL을 직접 계산하지 않지만 암시적으로 보존 (RL 없이 LLM Fine-Tuning)
- **KTO**: KL을 강하게 유지하며 기존 모델을 최대한 보존하면서 선호 최적화
- **GRPO**: KL을 사용하지 않고 Gradient Regularization을 활용하여 안정적 학습 수행

🚀 **요약하면:**  
KL은 "기존 모델과의 차이를 얼마나 제한할지"를 결정하는 역할을 하며, **PPO/DPO/KTO 등의 최적화 방법에서 핵심적으로 활용**됩니다.
