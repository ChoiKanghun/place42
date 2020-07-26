# React FrameWork 공부기록

## 1. 나는 Vanilla Script만 할 줄 알았다.

피신 끝나고 3월 중순부터 약 3개월 간 java spring과 함께 javascript를 공부했다. 

javascript에서도 프레임워크를 쓰지 않은 JS를 바닐라 스크립트라고 한다. 

프레임워크를 공부할 수 있었음에도 굳이 프레임워크를 하나도 사용하지 않고 바닐라 스크립팅만을 고집한 이유는 프로젝트 기반의 강의를 수료한 탓도 있겠지만, 코드 스쿼드에서 일하고 계신 윤지수(크롱) 님이 프론트엔드 전문가로서 제시한 커리큘럼을 따르고 싶었기 때문이다. 

사실 윤지수가 누군지 코드 스쿼드가 뭐하는 곳인지에 대해서는 아는 사람이 많이 없을 것이라고 생각한다. 그런데 거기에 대해 지금 말하기에는 너무 주제와 벗어난 것 같아서 생략하도록 하겠다. 

그  제시한 커리큘럼을 살펴보자. 아래 깃 주소에서 확인할 수 있다.  

https://github.com/crongro/front-end-curriculum 



<br>





![1](https://github.com/ChoiKanghun/ChoiKanghun_TIL/blob/master/img/0726_1.png?raw=true)

![2](https://github.com/ChoiKanghun/ChoiKanghun_TIL/blob/master/img/0726_2.png?raw=true)



![3](https://github.com/ChoiKanghun/ChoiKanghun_TIL/blob/master/img/0726_3.png?raw=true)



<br>



커리큘럼은 크게 세 가지로 나눠져 있고, 하나 하나에는 아래 정도의 분량이 담겨 있다. 



<br>

![4](https://github.com/ChoiKanghun/ChoiKanghun_TIL/blob/master/img/0726_4.png?raw=true)

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



## 첫 Framework, React



처음으로 JavaScript 프레임워크를 배워야 할 필요가 생겼다. `덕질이 밥 먹여준다` 프로젝트에 참여하면서 프론트엔드 팀원 5명과 얘기를 하다보니 프레임워크의 사용이 필요하게 됐다. 그리고 이를 위해 리액트를 학습해야 했다. 그 동안 바닐라 스크립트로 api도 보내고 받아와보고, 특히 json 객체를 라이브러리를 이용해 이리저리 만져보는 경험을 많이 했지만 Framework를 써본적이 없다는 사실이 큰 흠으로 느껴졌다. 

<br>



자바스크립트 프레임워크에는 여러 가지 종류가 있는데, 그중에서도 React JS 를 공부하기로 했다. 



<br>



## 왜 React 인가

![img](https://miro.medium.com/max/2000/1*fh5VNwJ0CfzV5sXf0o5_iA.png)



<br>



![img2](https://media.vlpt.us/images/wooder2050/post/56dfe437-721f-44b8-924e-2b949653ba4f/front_end_frameworks_section_overview.png)



<br>



일단 첫 번째 사진의 그래프만 봐도 대세는 REACT이다. vue가 반짝 2018년에 치고 올라왔지만, react에 의해 다시 역전당했다.  

또, 두 번째 사진을 보면 REACT가 현재 가장 사용률이 높을 뿐더러 제품 만족도(?) 또한 가장 높다. 

이렇게 리액트가 인기 있는 이유에는 여러가지가 있다. 하나는 단순성이다. MVC 중에서도 View에 집중한 프레임워크이기 때문에, 처음 배우는 사람도 러닝커브가 상대적으로 낮다. Angular 같은 경우에는 MVC 모두를 다루기 때문에 해당 개념에 대해 익숙하지 않은 사람은 배우기조차 힘든 것이 사실이다. 이와 관련해 React가 MVC 전체를 관리하는 것이 아니라서 React를 두고 프레임워크가 아닌 라이브러리라고 해야 한다는 글을 많이 접했다. 



<br>



### 리액트 네이티브(React Native) + SPA, CSR

  

React-Native를 이용하면 동일한 디자인을 사용하여 풍부한 모바일 UI 라이브러리를 활용할 수 있다. 일반 iOS 및 Android 앱과 거의 동일한 UI 빌딩 블록을 사용한다. 심지어 Objective-C나 Java, Swift로 작성된 구성 요소를 허용한다.



<br>



SPA(Single Page Application)와 CSR(Client Side Rendering) 또한 리액트의 주요한 장점이라고 할 수 있다. CSR과 대조되는 개념이 기존에 사용하던 방식인 SSR(Server Side Rendering)이다. SSR을 사용하는 경우 변화가 있을 때마다 페이지를 다시 로드해야 한다는 단점이 있었다. ajax라는 기술이 있지만 비동기적으로 불러올 이벤트가 많아질수록 시간도 오래거리고 유지보수 측면에서도 문제가 됐다. 



<br>



CSR(Client Side Rendering)은 이름에서 유추할 수 있듯이 클라이언트 단에서 렌더링하는 방식이다. 서버에서 데이터를 받아 이전과 비교해 수정된 데이터가 있는 화면만 새롭게 랜더링한다. 이를 통해 UX는 높이면서도 효율적인 코딩이 가능해졌다. 높여주면서 효율적으로 클라이언트 리소스를 사용하게 한다. 

 

 또 이전처럼 서버가 렌더링하는 대신 그냥 데이터를 보내주기만 하는 경우 안드로이드나 ios 등 모바일 플랫폼이 서버를 공유할 수 있게 E된다는 장점이 있다. 

<br>



## 가상 DOM



React의 또 다른 장점은 가상 DOM을 사용한다는 것이다. Virtual DOM은 렌더링 해야 할 표현들을 메모리에 미리 저장해뒀다가 새로운 요청에 대해 다른 점을 찾고, 실제 DOM과 동기화하는 프로그래밍 개념이다. 



<br>



DOM 에 직접 접근해서 무언가를 변경하는 방식(기존의 방식)은 html, css, js가 리렌더링 되어야 하기 때문에 속도가 늦어진다. 이에 대해 리액트를 사용하는 경우 가상 DOM을 이용하면 실제로 DOM을 조작하는 횟수가 줄어들고, 속도는 빨라진다. 



<br>



이 과정에 대해 잘 정리한 동영상이 있다. 

[video](https://youtu.be/BYbgopx44vo)



<br>



좀더 구체적인 과정은 이렇다. 

`데이터가 변경되면 -> 이전의 가상 DOM과 비교해 변경된 부분을 찾는다. -> 변경된 부분만 실제 DOM에 적용한다. ` 

이렇게 가상 DOM을 사용하면 사이트의 규모가 커질수록 얻을 수 있는 효율성과 속도 또한 더 커진다.



<br>




## How to use React





Reference - 



https://araikuma.tistory.com/640 

https://velopert.com/2597 

https://dev.to/marluanguerrero/why-is-important-to-learn-vanilla-javascript-first-before-opting-for-a-framework-or-library--5ffg 

https://www.playnexacro.com/#show:insight:893 

https://codeburst.io/javascript-trends-in-2020-b194bebc5ef8 

https://www.c-sharpcorner.com/article/what-and-why-reactjs/  
https://railsware.com/blog/why-use-react/ 
https://velog.io/@wooder2050/%EB%A6%AC%EC%95%A1%ED%8A%B8React%EB%8A%94-%EC%99%9C-%EC%93%B0%EB%8A%94-%EA%B1%B4%EB%8D%B0 
