프롬프트 엔지니어링에 대한 기본적인 이해가 있다는 전제하에 정리한 내용입니다. 

### 1. **체인 오브 쏘트(Chain of Thought, CoT) 활용**
CoT는 모델이 문제를 해결하는 과정을 단계별로 설명하도록 유도하는 기법입니다. 단순한 정답을 도출하는 것보다, 사고 과정을 명확히 하여 모델의 추론 능력을 향상시킬 수 있습니다. 특히, **수학적 문제 해결**, **논리적 추론**에서 효과적입니다.

#### 사례:
**문제**: "3살 때 내 파트너는 내 나이의 3배였다. 지금 내가 20살일 때, 내 파트너는 몇 살일까?"

**프롬프트 (CoT 적용)**:
```
Let's think step by step:
1. When I was 3 years old, my partner was 3 times my age, so they were 9 years old at that time.
2. Now, I am 20 years old, so I have aged 17 years from when I was 3.
3. Since my partner was 9 years old when I was 3, they would have aged 17 years as well.
4. Therefore, my partner's current age is 9 + 17 = 26.
```

이와 같은 방식으로, 모델이 사고 과정을 단계별로 나열하게 하면, 더 정확하고 논리적인 결과를 얻을 수 있습니다.

### 2. **자기 일관성(Self-consistency) 기법**
자기 일관성은 동일한 프롬프트를 여러 번 실행하여 다양한 결과를 도출한 후, 가장 일관된 답을 선택하는 방법입니다. 여러 경로에서 나온 결과를 비교하여 더 신뢰할 수 있는 출력을 선택할 수 있습니다.

#### 사례:
**문제**: 이메일의 중요성을 분류하는 시스템에서 이메일의 중요도를 "중요" 또는 "중요하지 않음"으로 분류할 때, 여러 번 프롬프트를 실행하여 결과를 비교합니다.

**프롬프트 (Self-consistency)**:
```
Classify the email as IMPORTANT or NOT IMPORTANT. Let's think step by step and explain why.
```
이렇게 프롬프트를 여러 번 실행하고, 각 출력에서 가장 자주 등장하는 결과를 채택하는 방식입니다. 이 기법은 모델이 일관된 논리를 유지하는 데 도움을 줍니다.

### 3. **롤 프롬프트(Role Prompting) 활용**
롤 프롬프트는 모델에게 특정 역할을 부여하여, 그 역할에 맞는 출력을 생성하도록 유도하는 기법입니다. 예를 들어, 모델에게 **여행 가이드**, **음식 평론가**, **교사** 등의 역할을 부여할 수 있습니다.

#### 사례:
**문제**: 여행지 추천

**프롬프트 (여행 가이드 역할)**:
```
You are a travel guide. Based on the following location, suggest 3 places to visit:
Location: "Paris"
```
이 프롬프트는 모델에게 여행 가이드의 역할을 부여하고, 그에 맞는 답변을 유도합니다. 역할에 따라 모델의 응답 스타일이나 내용이 달라지므로, 특정 상황에 맞는 프롬프트를 사용할 수 있습니다.

### 4. **트리 오브 쏘트(Tree of Thoughts, ToT) 기법**
ToT는 모델이 여러 가지 사고 경로를 동시에 탐색할 수 있게 해주는 방법으로, 복잡한 문제에 대해 다양한 가능성을 시도하고 그 중 최적의 답을 선택할 수 있습니다.

#### 사례:
**문제**: 복잡한 전략 게임의 레벨 디자인

**프롬프트 (ToT 적용)**:
```
Let's design a new level for a strategy game. Here are 3 possible locations for the level:
1. A desert with limited resources.
2. A futuristic city with advanced technology.
3. An ancient temple with traps and puzzles.
Choose one location and describe how the level will play out, considering the challenges each location presents.
```
여기서 모델은 각 장소에 대해 여러 사고 경로를 탐색하고, 가장 적합한 답변을 생성합니다. 이 기법은 **복잡한 시나리오**를 설계할 때 유용합니다.

### 5. **다양한 프롬프트 형식 실험**
프롬프트의 형식을 실험하여, 원하는 스타일이나 콘텐츠를 얻는 방법입니다. **질문 형식**, **명령문 형식**, **서술문 형식** 등 다양한 방식으로 동일한 주제에 접근할 수 있습니다.

#### 사례:
**주제**: Sega Dreamcast 게임 콘솔에 대한 설명

**프롬프트 (형식별 실험)**:
- **질문형**: "What was the Sega Dreamcast and why was it revolutionary?"
- **명령형**: "Describe the Sega Dreamcast console and explain why it was so revolutionary."
- **서술형**: "The Sega Dreamcast was a groundbreaking video game console that changed the industry with its innovative features, such as..."

이렇게 형식을 달리하면 모델의 응답 스타일이 달라지므로, 어떤 형식이 최적의 결과를 낳는지 실험해보는 것이 좋습니다.

---

출처 : [Prompt Engineering by google](https://drive.google.com/file/d/1AbaBYbEa_EbPelsT40-vj64L-2IwUJHy/view)
