### **TIL 200727(Mon)**

# React

## **선행지식**

 

 

HTML, CSS
(div, span, flexbox, display block, background-color ...)

 

 

A little of Vanilla JS
(let, const, function(args), var, array ...)

  

  

## **Why React**

  

  

React는 페이스북에서 만들었다. 리액트는 굉장히 인기가 많은데,요즘에는 회사에서 디폴트로 리액트를 쓸 정도다. 또 airbnb, npm, netflix 등의 유명한 대기업들도 리액트를 사용하고 있다.

 

 

[https://camo.githubusercontent.com/2123278a9b06e71669c8db1b55418e6fa33f6954/68747470733a2f2f6d69726f2e6d656469756d2e636f6d2f6d61782f323030302f312a666835564e774a3043667a5635735866306f355f69412e706e67](https://camo.githubusercontent.com/2123278a9b06e71669c8db1b55418e6fa33f6954/68747470733a2f2f6d69726f2e6d656469756d2e636f6d2f6d61782f323030302f312a666835564e774a3043667a5635735866306f355f69412e706e67)

주당 다운로드 횟수만 500만에 육박하고, 페이스북에서도 사람, 시간, 돈을 투자해서 더욱 좋은 기술이 되게끔 만들고 있다.

  

  

프론트엔드의 생태계를 봐도 현재 리액트가 가장 많이 쓰이면서도 다시 사용할 의사가 있다는 응답 비율이 가장 높다.

  

  

[https://camo.githubusercontent.com/42fb36bc948909947495d6a40188bea72cd124fa/68747470733a2f2f6d656469612e766c70742e75732f696d616765732f776f6f646572323035302f706f73742f35366466653433372d373231662d343462382d393234652d3262393439363533626134662f66726f6e745f656e645f6672616d65776f726b735f73656374696f6e5f6f766572766965772e706e67](https://camo.githubusercontent.com/42fb36bc948909947495d6a40188bea72cd124fa/68747470733a2f2f6d656469612e766c70742e75732f696d616765732f776f6f646572323035302f706f73742f35366466653433372d373231662d343462382d393234652d3262393439363533626134662f66726f6e745f656e645f6672616d65776f726b735f73656374696f6e5f6f766572766965772e706e67)

 

 

또한 세계적으로 아주 큰 커뮤니티가 형성돼 있어서 궁금한 게 생기면 그것을 다른 누군가가 질문했을 확률이 100%이다.

 

 

또한, React는 가볍다. 프레임워크가 가벼워서 좋은 점은 배울 게 많이 없다는 뜻이고, 프레임워크를 갈아타더라도 쓸모없어지는 지식도 별로 없다는 뜻이다.

 

 

## **React Start**

 

 

React를 사용하기 위해서는 React만 사용해서는 안 된다. 이게 무슨 말이냐면, 리액트 자체가 매우 현대적인 코드로 이루어져 있어서 브라우저가 리액트 코드를 이해하지 못한다. 따라서 현대적인 리액트 코드를 브라우저가 인식할 수 있도록, 좀더 못생기게 만들어 줄 코드가 필요하다.

 

 

이를 위해서는 몇 가지 준비물이 필요하다. Web Pack을 다운로드해야 하고, Babel도 다운로드 해야 한다. 그 다음에 컴파일도 해야 하고, 그 파일을 다른 파일에 넣어야 하고 ... 할 게 정말 많다.

 

 

그러나 2016년 이후로는 이 단계를 굳이 거칠 필요가 없게 됐다.
그 이유는 `create react app` 이라는 것 덕분이다.

 

 

이 앱은 명령 하나를 실행하면 React Web App을 설치할 수 있게 도와주는 매우 실용성 있는 기능을 가지고 있다.

 

 

이제 이 React Web App을 실행해보자. React Web App을 실행하기 전에 준비해야 할 또 다른 준비물은 `npm`, `npx`가 있다. 이 정도는 미리 설치해두자.

 

 

0727_1 jpg

 

 

다음으로 해야 할 것은 npx create-react-app을 이용한 폴더만들기 이다. 

 

 

`npx create-react-app whateveryouwanttoname` 으로 원하는 폴더명으로 리액트 앱 폴더를 생성해보자.  

성공 시 `happy hacking!` 이라는 문구가 뜬다.

  

  

나는 `movie_app_2020` 이라는 이름으로 폴더를 생성했다. 

  

  

## 기본 파일 설정

  

  

### [README.md](http://readme.md) 작성

  

  

여기까지 에러 없이 진행했다면 [README.md](http://readme.md) 파일에 프로젝트에 대한 설명을 간단하게 적어준다. 

 

 

### package.json

 

 

그리고 폴더 내의 파일들을 보면 .gitignore부터 시작해서 여러가지 파일들이 있다.  

해당 파일들 중에 `package.json` 이라는 파일도 있는데, 해당 파일의 내용 중 우리가 다룰 것은 scripts 안에 들어가는 부분이다. 입문 단계에서 배우면서 사용할 명령어는 start와 build이니 그것을 제외하고는 모두 지워주자.

 

 

### yarn.lock 삭제

 

 

폴더 내에 있는 yarn.lock 파일은 삭제해주자. 

 

  

### favicon.ico

 

 

파비콘은 다음과 같이 탭에 뜨는 이미지 및 텍스트이다. 

 

 

0803_2

 

 

## NPM Start && Git init

이제 우리가 생성한 폴더로 들어가서 `npm start` 라는 명령어를 입력해보자. 

 

 

0803_1.jpg

 

 

[localhost](http://localhost) 부분을 브라우저 url에 입력해보면 리액트에서 기본적으로 제공하는 화면이 뜬다. 

 

 

### Git init

github.com에서 계정을 생성하고 폴더를 하나 생성하자 (우리가 생성한 폴더랑 같은 이름으로 생성하는 것을 추천한다.). 

그리고 만든 깃헙 리포지토리 주소를 복사해서

 

 

`git clone remote origin clone한 주소` 형태로 명령을 내리자. 

그 다음 `git add` → `git commit "init"` → `git push remote origin` 명령을 순서대로 내려주자.

 

 

## Deleting unnecessaries

 

 

여러가지 쓰지 않는 줄들을 지워줄 필요가 있다.  

먼저 index.js에서 import `./index.css` 및 `import* as serviceWorker from ...` 줄을 지워준다. 쓰지 않으므로. 

또한 `serviceWorker.unregister()` 부분도 지워준다. 

 

 

### 추가적으로 지워줄 파일들

logo.svg 

serviceWorker.js

index.css  

app.test.js 

app.css 

(최종적으로 index.js 와 app.js만 남도록.) 

 

 

## function App() - 리액트가 동작하는 방식

public의 index.html에는 `<div id = "root"></div>` 라는 요소 외에는 아무런 내용이 없다. 그런데 App.js의 `function App()` 에서 return값으로 HTML 을 적어주면, 해당 내용이 root 안에 그려진다. 

왜 function App이어야 하느냐는 index.js 파일에서 확인할 수 있다. 해당 js 파일에서 `ReactDOM.render(App />` 이라는 명령어를 쓰기 때문에 App이라는 함수를 사용한다고 이해하면 되겠다. 

바로 이것이 REACT가 동작하는 방식이고, 이것을 활용하는 게 우리의 목표다. 

 

  

## JSX

 

 

위에서 설명한 내용 중 `<App />` 이라는 것을 render 한다는 내용이 있었다. 쉽게 설명하면 `<App />` 은 App 이라는 함수(또는 클래스)의 리턴값을 그려낸다고 이해하면 되겠다. 그러니까 자바스크립트가 html을 그려낸다는 뜻인데, 이러한 JavaScript와 html의 조합을 JSX라고 한다. 

 

 

JSX의 단점은 다른 프레임워크에서 쓸 일이 없다는 것. 대신 react에서는 필수적으로 다뤄야 할 개념이라는 것 정도를 알아두자. 

 

 

## Component

 

 

JSX에서 `<App />` 이라는 요소가 있다고 할 때, 이러한 요소 하나 하나를 component라고 한다. 이러한 컴포넌트를 사용할 때에는 `import React from "react";` 를 파일 상단에 꼭 써줘야 한다. 그리고 파일 최 하단에는 `export default App` 을 꼭 적어줘야 한다. 즉 시작과 끝에 들어가야 할 부분이 명확하게 있다는 것이다.

 

 

### Component 끼리 import하여 사용할 수 있는가

 

 

결론적으로 말하면 있다. <App /> 컴포넌트가 어떤 HTML을 리턴할 때, 또 다른 component(예를 들어 <Potato />)를 그려낼 수 있다는 것이다. 다만 주의해야 할 점은 index.js 에서  render하는 것은 딱 하나의 컴포넌트라는 것이다. (우리의 경우 App 컴포넌트가 되겠다.) 그러니까 ReactDOM.render하는 파일(index.js)에서는 단 하나의 컴포넌트(<App />)만 import및 사용하고, 컴포넌트끼리는 한 컴포넌트에서 여러 개의 다른 컴포넌트를 사용할 수 있다고 이해하면 되겠다. 

 

 

### Component에 데이터 넣어 보내기

 

 

여지껏 component를 사용할 때에는 <App /> 같은 형태만 사용했었다. 그러나 컴포넌트에도 데이터를 넣어서 렌더시키는 방법이 있다. 마치 함수에 인자를 넣듯이. 사용형식은 다음과 같다. 

 

 

`<Food fav="kimchi" />`

 

 

위의 코드가 의미하는 바는 이렇다. 

Food 컴포넌트를 불러오는데, props(propeties) 중 fav라는 이름을 가진 녀석의 값으로 kimchi를 넣어라. 

 

 

한편 Food Component의 경우 이렇게 생겼다고 해보자. 

 

 

```jsx
function Food (props) {
	return <h1>I like {props.fav} </h1>
}
```

 

 

Food component에 넣은 props는 properties의 약자이다. Food 컴포넌트가 어떻게 생겼는지도 확인했으니까 실제로는 어떻게 렌더링될까? 그렇다. 예상하는 대로 `I like Kimchi` 가 렌더링 된다. props는 굳이 props.fav처럼 쓰는 것을 피하기 위해 array형식으로 사용할 수도 있다. 아래와 같이 말이다. '

참고로 어떤 방식이든 return 값에 { }를 쓰는 부분은 javascript라는 뜻이고 { }가 없는 부분은 모두 HTML이다.

 

 

```jsx
function Food({ fav }) {
	return <h1>I like {fav} </h1>
}
```

 

 

## Map

자바스크립트에는 map이라는 함수가 있다. 어떤 array가 있고, 해당 array의 요소 하나하나를 돌아가면서 어떤 함수를 적용하는 함수이다. map은 우리가 json이라는 데이터 객체를 받아서 쓰기 위해 꼭 사용해야 할 함수라고 생각하고, 그래서 소개한다. 

 

 

예를 들어 `const friends = ["kchoi", "jaejeon", "hycho", "dyu"]` 라는 배열이 있다고 하자. 

나는 `map` 을 써서 해당 배열의 요소 뒤에 `!!` 라는 특수문자를 넣어 console.log로 찍어볼 것이다. 

이것을 코드로 짜보면 다음과 같이 된다.

  

 

```jsx
friends.map(cur => {
	console.log(cur + "!!");
	return 0;
});
```

 

 

위와 같이 해주면 우리가 의도한 대로 배열의 요소 뒤에 !! 만 붙어서 출력된다. cur은 arrow function의 인자로 들어오는 값으로, 배열 하나하나를 돌 때 그 요소 하나가 될 녀석이다. (arrow function에 대해 모른다면 구글링을 통해 먼저 알아보고 오자.)

 

 

그리고 map은 특정 값을 배열로 만들어 리턴한다는 것이 forEach라는 함수와 다른 점이다. 즉 return 부분에 `cur + " !! "` 를 적어주었다면 friends 배열의 요소 뒤에 !! 이 붙은 `배열` 을 리턴한다. 

ex) ["kchoi !! ", "jaejeon !! ", "hycho !! ", "dyu !! "]
