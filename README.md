# React FrameWork 공부기록

## 1. 나는 Vanilla Script만 할 줄 알았다.

피신 끝나고 3월 중순부터 약 3개월 간 java spring과 함께 javascript를 공부했다. 

javascript에서도 프레임워크를 쓰지 않은 JS를 바닐라 스크립트라고 한다. 

프레임워크를 공부할 수 있었음에도 굳이 프레임워크를 하나도 사용하지 않고 바닐라 스크립팅만을 고집한 이유는 프로젝트 기반의 강의를 수료한 탓도 있겠지만, 코드 스쿼드에서 일하고 계신 윤지수(크롱) 님이 프론트엔드 전문가로서 제시한 커리큘럼을 따르고 싶었기 때문이다. 

사실 윤지수가 누군지 코드 스쿼드가 뭐하는 곳인지에 대해서는 아는 사람이 많이 없을 것이라고 생각한다. 그런데 거기에 대해 지금 말하기에는 너무 주제와 벗어난 것 같아서 생략하도록 하겠다. 

그  제시한 커리큘럼을 살펴보자. 아래 깃 주소에서 확인할 수 있다.  

https://github.com/crongro/front-end-curriculum 



<br>





![1](C:\Users\rkdgn\OneDrive\Desktop\Duck_feeds_us_private-master\1.png)

![2](C:\Users\rkdgn\OneDrive\Desktop\Duck_feeds_us_private-master\2.png)



![3](C:\Users\rkdgn\OneDrive\Desktop\Duck_feeds_us_private-master\3.png)



<br>



커리큘럼은 크게 세 가지로 나눠져 있고, 하나 하나에는 아래 정도의 분량이 담겨 있다. 



<br>

![4](C:\Users\rkdgn\OneDrive\Desktop\Duck_feeds_us_private-master\4.png)

<br>



## 왜 바닐라스크립트를 먼저 배워야 하나



프레임워크는 분명 편리함을 위해 만들어진 도구다. 그렇기에 미리 공부하지 말라고 하면서 바닐라 스크립트를 최대한 다뤄보길 권하는 이유에 대해 궁금해졌다. 

바닐라스크립트를 배워야 하는 이유를 알아보니 자잘한 건 빼놓고 크게 두 가지 이유가 있었다. 

첫째는 바닐라스크립트가 더 효율적으로 작동한다는 점이다. 예를 들어 React라는 프레임워크를 사용하는 경우 바닐라스크립트로 짰을 때보다 매번 105kb의 용량을 더 차지한다. 작은 규모의 프로젝트에서는 큰 상관이 없겠지만 방문자 수가 하루에 50000정도만 되어도 5.25기가바이트의 추가적인 트래픽을 소모하게 된다. 



<br>



둘째로, 지금은 사장된 jquery부터 시작해 vue, react js등의 프레임워크 등이 해마다 나오고 있다. 이런 프레임워크들이 자주 나오는 만큼 프레임워크 트렌드도 아주 빨리 바뀌는데, 이 프레임워크마다 문법이 워낙 다르다. 예를 들어 Ajax(Asynchronous Javascript and Xml)라고 해서 비동기적으로 json 파일을 받아오는 기술이 있다.  이 기술을 2018년 까지만 꽤나 쓰이다가 현재에는 거의 완전히 사장돼버린 jquery와 요즈음 핫한 react js를 이용해 짜보면 다음과 같이 나온다.



<br>



jquery

```javascript
$.ajax({ 
    url: "/rest/1/pages/245",
    data: { name: "홍길동" }, 
    method: "GET", 
    dataType: "json"
})
```





<br>



React.js

```javascript
axios.get('/user?ID=12345')
  .then(function (response) {
    console.log(response);
  })
  .catch(function (error) {
    console.log(error);
  });
```



<br>



그런데 바닐라 스크립트를 잘 익혀두면 프레임워크 하나가 새로 나왔을 때 갈아타는 것도 바닐라스크립트에 대한 이해가 높으면 상대적으로 수월해진다.



## 프레임워크를 쓰면 어떤 장점들이 있나



<br>

**프레임워크의 장점**

- 체계적인 코드관리로 유지보수가 용이하다.
- 기본설계 및 기능 라이브러리를 제공하여 개발 생산성이 높다
- 코드에 대한 재사용성이 높다
- 추상화된 코드 제공을 통해 확장성이 좋다

#####  

사실 자바스크립트 언어로 프로그래밍을 하다보면 굉장히 보기가 복잡해지기 십상이다. 왜냐하면 이 언어가 유난히 `근본`이 없어서이다. 바닐라스크립팅을 하며 이 언어가 워낙 근본이 없다보니, 어떤 라인에서 작성한 함수의 인자로 무엇을 넘겼는지 찾아보기 위해 많은 시간을 낭비한 경험이 여러 번 있었다. 

 

 그러나 프레임워크에서는 정형화된 스크립트 패턴을 통해 보기 쉽게 정리할 수 있다. 스크립트 패턴이 정형화되어 있다는 것은 생각보다 많은 장점을 제공한다. 가장 먼저 보기가 편하다.  아래 예시를 보자.

 

VanillaScript 

```javascript
function ajaxFunc(url) {
    var oReq = New XMLHttpRequest();
    oReq.open('GET', url);
    oReq.addEventListener('load', function() {
        something;
    });
    oReq.send();
}
```

 

jquery 

```javascript
$.ajax({ 
    url: "/rest/1/pages/245",
    data: { name: "홍길동" }, 
    method: "GET", 
    dataType: "json"
})
```

 

당장에 사장된 jquery만 해도 위의 바닐라스크립트보다 훨씬 직관적이다. 보기 쉽다는 게 무슨 뜻인지 대충 감이 올 것이다. 

보기가 편하다 보니 팀 프로젝트에서도 서로 간의 코드를 보다 쉽게 확인할 수 있다. 그리고 정형화되어 있기 때문에 반복적인 부분을 제거함으로써 시간도 단축된다. 단축된 시간은 생산성으로 이어진다. 그리고 한번 만들어놓은 정형화된 스크립트를 재사용하기에도 용이하다. 

 

<br>



왜 React 인가



<br>

## 첫 Framework, React



처음으로 JavaScript 프레임워크를 배워야 할 필요가 생겼다. `덕질이 밥 먹여준다` 프로젝트에 참여하면서 프론트엔드 팀원 5명과 얘기를 하다보니 프레임워크의 사용이 필요하게 됐다. 그리고 이를 위해 리액트를 학습해야 했다. 그 동안 바닐라 스크립트로 api도 보내고 받아와보고, 특히 json 객체를 라이브러리를 이용해 이리저리 만져보는 경험을 많이 했지만 Framework를 써본적이 없다는 사실이 큰 흠으로 느껴졌다. 

<br>

자바스크립트 프레임워크에는 여러 가지 종류가 있는데, 그중에서도 React JS 를 공부하기로 했다. 


## How to use React

## What is SPA


나는 바닐라 스크립트밖에 할줄 모른다.

프레임워크 배우게 된 계기

React JS 접하다.(why) -> React JS을 쓰기로 (what) -> React JS (how)

React를 배우기 전에 사전에 배울 것들 - SPA 





Reference - 



https://araikuma.tistory.com/640 

https://velopert.com/2597 

https://dev.to/marluanguerrero/why-is-important-to-learn-vanilla-javascript-first-before-opting-for-a-framework-or-library--5ffg 

