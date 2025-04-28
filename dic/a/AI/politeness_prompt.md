# politeness한 표현이 존대말과 다른 이유

## 배경

모 SNS에서 "습니다" 체 같은 존칭을 사용하는 것이 더 좋은 결과를 준다는 표현이 있는데, 
이 표현의 잘못 된 점을 지적하기 위한 페이지. 

## 결론

- AI는 맥락을 이해시키는 것이 가장 중요하고, 그 과정에서 존칭 등의 표현은 관련이 없다. 즉, 반말이라도 맥락을 충분히 설명한다면 그에 준하는 대답을 얻을 수 있다. 

## politeness하게 표현하다

AI에게 “politeness”하게 표현한다는 것은 단순히 한국어의 존댓말(–습니다체) 사용 여부를 넘어, **요청의 어조와 문장 설계 전체**가 “부드럽고 협력적인 태도”를 반영하도록 하는 걸 의미합니다. 구체적으로 살펴보면:

1. **소프트닝(softening) 표현 사용**  
   - “~해 줘” 대신 “~해 줄 수 있을까?”, “~해 주시면 감사하겠어”처럼 요청어 끝에 완곡어법을 붙여 명령이 아닌 부탁으로 만듭니다.  
   - 예)  
     - 급한 톤(impolite): “이 보고서 요약해.”  
     - 부드러운 톤(polite): “이 보고서를 요약해 줄 수 있을까? 고마워!”

2. **감사·인정 문구 삽입**  
   - 요청 전·후에 “제발(please)”, “고마워(thank you)”, “도와줘서 고마워” 등을 넣어, AI가 “내가 쓴 답변이 환영받는구나”라고 학습하게 만듭니다.  
   - 예) “Could you please explain how TCP port forwarding works? Thank you in advance.”

3. **맥락과 배경 제공**  
   - 단순히 “번역해”보다 “이 문단이 기술 문서용인데, 비전문가도 이해하기 쉽게 번역해 주시면 좋겠어”처럼 **왜** 요청하는지 설명을 덧붙이면, 모델이 더 적절한 어조와 수준으로 응답할 확률이 높습니다.

4. **질문형·협력형 문장 구조**  
   - “이걸 해”처럼 강제적인 서술형(명령문)보다 “이렇게 해볼까?”, “이 부분을 검토해 줄래?”처럼 **함께 일하는 동료에게 부탁하듯** 묻는 구조가 좋습니다.

---

### 반말 vs. 존댓말  
- **반말**로도 충분히 공손할 수 있습니다.  
  > “이 파일 좀 확인해 줄래? 고마워.”  
- **존댓말**(–습니다체)을 쓰면 격식은 살지만, 무조건 정중한 것만은 아닙니다.  
  > “이 파일을 확인해 주실 수 있나요? 감사합니다.”  

중요한 건 **말투의 형태(formality)** 가 아니라, **‘요청’ 그 자체가 협력적이고 존중하는 태도로 짜여 있느냐**입니다.  
따라서 AI에게 politeness하게 묻는다는 건:

- “명령”이 아니라 “부탁”으로 말문을 열기  
- 감사·인정 어투를 덧붙이기  
- 배경·목적을 간단히 설명해 주기  

이렇게 하면 LLM은 “이 입력에 신경 써서 답해야겠다”라고 인식해, 더 친절하고 정확한 결과물을 내줄 가능성이 높아집니다.

## 공손한 표현에 대한 연구

단순한 ‘속설’이 아니라 실제로 정중함 레벨(politeness level)에 따라 LLM의 성능을 정량적으로 평가한 연구들이 있습니다. 대표적인 예를 들어 보겠습니다.

1. **Ziqi Yin 등(2024), “Should We Respect LLMs? A Cross‑Lingual Study on the Influence of Prompt Politeness on LLM Performance”**  
   – arXiv에 게시된 이 논문은 영어·중국어·일본어 3개 언어로 된 다양한 과제(task)에서 “공손함 레벨”을 조절한 프롬프트를 테스트했습니다.  
   – **결과**: 무례한(rude) 프롬프트는 정확도·일관성·정보 완전성에서 유의미하게 성능 저하를 일으켰고, 지나친 과도한 공손함(over‑politeness) 역시 최적 성능을 보장하지 않았습니다. 언어별로 ‘가장 적절한(politeness sweet‑spot)’ 레벨이 다름을 발견해, 실제 응용 시 “중간 정도의 공손함”을 권장합니다.  ([[2402.14531] Should We Respect LLMs? A Cross-Lingual Study on the Influence of Prompt Politeness on LLM Performance](https://arxiv.org/abs/2402.14531))

2. **와세다대·RIKEN 연구팀(2024), “Please Be Polite to ChatGPT” (Scientific American 기사)**  
   – Waseda University와 RIKEN Center for Advanced Intelligence Project 합동 연구(2024년 초 발표)를 소개하며, 공손한 프롬프트가 **더 높은 품질의 응답**을 끌어낼 수 있음을 보고했습니다.  
   – 특히 “Take a deep breath and work on this problem step‑by‑step” 같은 **supportive prompt**가 기초 추론(math reasoning) 과제에서 정확도를 크게 높였다고 합니다.  ([Should You Be Nice to AI Chatbots Such as ChatGPT? | Scientific American](https://www.scientificamerican.com/article/should-you-be-nice-to-ai-chatbots-such-as-chatgpt/))

3. **Google DeepMind ‘Supportive Prompts’ 연구**  
   – 위 Scientific American 기사에서 언급된 바와 같이, Google DeepMind 연구진도 “지지적(supportive)” 프롬프트가 LLM의 단계적 문제 해결(step‑by‑step reasoning) 능력을 향상시킨다는 결과를 발표했습니다.  ([Should You Be Nice to AI Chatbots Such as ChatGPT? | Scientific American](https://www.scientificamerican.com/article/should-you-be-nice-to-ai-chatbots-such-as-chatgpt/))

---

이처럼 **peer‑reviewed 전처리(preprint) 논문**과 **기업 연구**에서 “프롬프트의 어조(tone)가 모델의 잠재 공간(latent space)에서 다른 위치를 점유하게 하고, 이로 인해 산출(output) 품질이 달라진다”는 실험적·이론적 근거를 제시하고 있습니다. 단, “과도한 예절”이 항상 좋은 건 아니므로, 보통 **중간 정도의 공손함**을 유지하는 것이 가장 효율적이라는 점도 함께 유의하시면 좋겠습니다.
