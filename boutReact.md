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

그리고 map은 특정 값을 배열로 만들어 리턴한다는 것이 forEach라는 함수와 다른 점이다. 즉 return 부분에 `cur + " !! "` 를 적어주었다면  friends 배열의 요소 뒤에 !! 이 붙은 `배열` 을 리턴한다. 

ex) ["kchoi !! ", "jaejeon !! ", "hycho !! ", "dyu !! "]

또한 map의 인자로 함수(이름만)를 넘겨주면 함수를 각 요소마다에 적용할 수 있다. 

## Prop-Types

먼저 PropTypes를 사용하기 위해서는 `npm i prop-types` 명령어를 통해 설치작업을 해주어야 한다. 설치가 끝났다면, PropTypes를 사용해보자. 

  

  

PropTypes는 우리가 component에 값을 넘겨줄 때, 해당 값이 숫자여야 한다면 숫자인지 아닌지, 문자여야 한다면 문자인지 아닌지 판별해주는 역할을 한다. 

  

  

사용은 다음과 같이 선언하여 할 수 있다. 

`imort PropTypes from "prop-types"`  

  

  

### prop-types 사용법

  

   

간단한 예제를 통해 알아보자. 

예를 들어 Food라는 함수가 property로 `name`, `age` 를 받는다고 치자. 

그렇다면 다음과 같은 형태로 선언될 것이다. 

```jsx
function Food({name, age}) {
	...
}
```

이 경우 Food가 받는 인자는 name과 age이며 직관적으로 name은 string, age는 number형이어야 한다는 것을 알 수 있다. 

이와 같은 상황에서 우리는 다음처럼 prop-types를 지정해줌으로써 name과 age에 원하는 형태의 값이 들어오도록 만들 수 있다. 만약 다른 형태의 값이 넘어온다면 에러를 발생시킨다 .

```jsx
Food.propTypes  = { 
	name: PropTypes.string.isRequired,
	age : PropTypes.number.isRequired
  // 위에서 import propTypes from "prop-types"라고 했음.
}
```

- 참고로 isRequired는 꼭 넘겨줘야 한다는 뜻으로, 굳이 쓸 필요가 있는 건 아니다.
- 다만 propTypes라는 이름은 변경해선 안 된다.
- PropTypes를 써준다면 이후 방대한 양의 자바스크립트 코드에서 보다 쉽게 에러를 잡아낼 수 있다.

## Class Component

이번에는 클래스 컴포넌트에 대해 얘기할 차례이다. 

지금까지 썼던 컴포넌트들은 모두 함수형태였다. 그러나 json 데이터를 주고 받기 위해 함수형 컴포넌트보다는 클래스 컴포넌트를 더 많이 사용한다. 클래스 컴포넌트라고 해서 함수형 컴포넌트와 크게 달라지는 것은 아니다. 다만 함수 외에 여러 가지가 추가될 뿐이다. 특히 클래스 컴포넌트의 경우 함수형 컴포넌트에는 없는 `state` 라는 것을 가진다. 

### 사용형식

class 컴포넌트의 사용형식은 다음과 같다. 함수형 컴포넌트를 어떻게 바꾸면 되는지 한눈에 확인할 수 있을 것이다. 

```jsx
//함수형 컴포넌트
function App() {
	return <div> something <div>;
}

//클래스 컴포넌트
class App extends React.Component {
	render() {
		return <div> something <div>;
	}
}
```

기억해둬야 할 것이 하나 있다. 

react는 자동적으로 클래스 컴포넌트의 render 메소드를 실행한다. 자동으로 ! 

그렇다면 아까 얘기한 state는 무엇일까. 

state는 데이터를 담아두는 공간이고, state 안에 있는 데이터는 변경할 수 있다. 

다시 한번 강조한다. state는 데이터를 담아두는 공간. 데이터 변경 가능. 

사용형식은 다음과 같다. 

```jsx
class App extends React.Component { 
	state = {
		count: 0
	}

	render() {
		return <div>{this.state.count}</div>;
	}
}
```

위와 같이 써주면 react는 div안에 count의 값인 0을 출력할 것이다. 

state의 특이한 점은 `=` 을 쓰는 것이 아니라 `:` 을 쓴다는 점이다. 

또한 `;` 도 쓰지 않는다. 

### class methods

클래스 내에는 state 외에도 여러가지 메소드를 넣을 수 있다. 

무슨 말인지 사용예제를 통해 알아보자. 

```jsx
class App extends React.Component {
	state = {
		count: 0
	}

	add = () => {
		this.setState({ count: this.state.count + 1})
	}

	minus = () => {
		this.setState(current => { count: current.count + 1 })
	}

	render() {
		return ( 
				<div>The number is : {this.state.count}</div>
				<button onClick={this.add}>Add</button>
				<button onClick={this.minus}>Minus</button>
		);
	}
}
```

먼저 설명하고 싶은 것은 onClick시 왜 add()가 아닌 add를 호출하는가이다. 그것은 자바스크립트가 작동하는 원리 때문인데, 자바스크립트에서는 add() 같은 형식으로 적어주면 일단 실행하고 본다. 그렇기 때문에 우리가 의도하지 않은 이벤트가 발생하는 경우를 방지하기 위해 그냥 add를 적어주는 것이다. 

add와 minus는 setState라는 메소드를 쓰고 있다. 만약 setState를 쓰지 않고 그냥 1을 더한다면, 화면을 새로고침해야 값이 바뀌게 된다. 생각해보면 그것이 UX 면에서 얼마나 안 좋을지 예상할 수 있을 것이다. setState의 역할은 여러분이 예상하는 대로 state 내의 필드 값을 바꾸는 것이다. 

또한 add와 minus가 미묘하게 다른데, current라는 키워드를 쓰는 것이 최근에 나온 fancy한 방법이라고 하니 참고하자. 

## React class 컴포넌트의 Lifecycle

LifeCycle이라는 용어를 보고 겁먹을 필요는 없다. 진짜 언제 생성되고 언제 죽는지에 대한 얘기다. 

지금까지 배운 react class 컴포넌트는 render()만을 기본적으로 가졌다. 그러나 리액트 클래스는 더 많은 메소드를 기본적으로 가지고 있다. 

그 종류로는 constructor(),  componentDid

### constructor(props)

constructor()는 사실 리액트가 아니라 자바스크립트에 있는 것이다. 사용형식은 다음과 같다. 

```jsx
constructor(props) {
	super(props);
	...
}
```

기본적으로 constructor 메소드는 위와 같은 형태를 지켜주어야 사용할 수 있다. constructor 메소드는 컴포넌트가 렌더되기 전, 즉 컴포넌트를 읽을 때 가장 먼저 실행하는 메소드이다. 

### componentDidMount()

componentDidMount()는 constructor()와는 정반대로 render된 이후에 발생하는 메소드이다. 딱히 지켜야 할 양식은 없고 그냥 `componentDidMount() { ... }` 와 같은 형식으로 사용하면 된다. 

기억하자. 순서는 constructor() ⇒ render() ⇒ componentDidMount() 순이다.

### componentDidUpdate()

componentDidUpdate의 경우 위에서 언급한 setState와 같은 업데이트가 발생했을 경우 실행하는 메소드이다. 변경이 일어나면 react는 새로 render하고 componentDidUpdate()를 호출한다. 예를 들어 다음과 같은 코드가 있다고 하자.

```jsx
class App extends React.Component {
	state = ...
	add = ...
	minus = ...

	componentDidUpdate() {
		console.log("component updated!");
	}
	render() {
		console.log("render execute");
		return (
				<div>The Number is : {this.state.count}</div>
				<button onClick={this.add}>add</button>
				<button onClick={this.minus}>minus</button>
		);
	}
}
```

위와 같은 상황에서 add 또는 minus 버튼을 누르는 경우 콘솔창에는 다음과 같은 문장이 출력된다는 뜻이다. 

```jsx
render execute
component updated!
```

## isLoading으로 loading 효과 주기.

state에는 isLoading이라는 필드가 기본적으로 형성되어 있다. 이것은 굳이 건들지 않는 이상 로딩중일때 `true`로 설정되어 있다. 우리는 이것을 이용해 loading중인 경우 특정 메시지를 띄우고, 모든 로딩이 끝나면 렌더링하는 방법에 대해 알아볼 것이다. 

다음과 같이 class가 선언되어있다고 해보자. 

```jsx
class App extends React.Component {
	state = {
		isLoading: true
	}

	componentDidMount() {
		setTimeout( () => {
			this.setState({isLoading:false});
		}, 5000);
	}

	render() {
		const { isLoading } = this.state;
		//윗 문장은 const isLoading = this.state.isLoading과 같다.
		return (<div>{isLoading ? "Loading..." : "We are ready"}</div>);
	}
}
```

위의 코드에 따르면, 최초의 isLoading은 true이므로 화면에는 `Loading...`이 출력된다. 그러나 componentDidMount의 setTimeout 메소드에 의해 정확히 5초뒤 isLoading이 false가 되면서 출력되는 문구가 `We are ready` 로 바뀐다. 

이러한 방법을 써서 우리가 무엇을 할 수 있냐면, 우리가 보여줄 전체 화면이 load되는 동안 로딩중이라는 메시지를 화면에 출력하도록 만드는 것이다.

## axios

우리는 axios라는 것을 사용하여 데이터를 fetch 해볼 것이다. fetch는 무언가를 가져온다는 뜻이며, 우리의 경우 api를 가져올 것이다. api를 가져오는 것은 필수적으로 할 줄 알아야 하는 기술 중 하나다. axios는 api를 가져오는 것을 보다 쉽게 도와줄 도구이다. 그러니 좀 낯설더라도 경계하지 말자 .

axios를 사용하기 위해서는 먼저 `npm install axios`를 통해 axios를 다운받아야 한다. 

다운로드가 완료되었다면 axios에 대해 본격적으로 알아보도록 하자. 

YTS라는 불법 영화 다운로드 사이트가 있다. 해당 사이트가 제공하는 api를 axios로 가져와보자.   

api는 다음의 주소로부터 가져올 수 있다. 

https://yts-proxy.now.sh/list_movies.json

(by nomad coders)

사이트에 들어가보면 json 목록이 뜬다. (json은 javascript object notation의 약자다. 이것에 대해 모른다면 그냥 데이터를 포함하고 있는 텍스트라고 이해하면 되겠다.)  json이 굉장히 보기 싫게 나오는 분들은 chrome extension에서 json formatter를 받아서 보자. 

0804_1

위의 json 데이터는  json 배열 안에 data 배열이 있고, 또 그 안에 movies 배열이 여러 개가 나열되어 있다. 우리가 접근할 대상은 movies 하나하나라는 것을 머리에 넣고 계속 진행해보자 .

### axios 사용하기

가장 먼저 해야할 것은 파일 맨 위에 `import axios from "axios"`라고 써주는 것이다. 

axios를 사용하는 틀은 다음과 같다. 

`axios.get(URL)` 

얼마나 간단한가 ?!

그런데 위와 같은 방식으로 써주면 데이터를 불러오긴 하지만 데이터를 저장하지는 않는다. 데이터를 저장하기 위해  다음과 같이 써줘보자.

`const movies = axios.get("url")`

여기서 중요한 건, axios가 그렇게 빠르지 않다는 것이다. 그래서 우리는 javascript에게 axios가 데이터를 불러올 때까지 기다리라고 명령 해줄 필요가 있다.   

이를 위해 다음과 같은 구조를 만들었다. 

```jsx
class App extends React.Component {
	state = {
		...
	}

	getMovies = async() => {
		const movies = await axios.get("~~~~");
	}

	componentDidMount() {
		this.getMovies();
	}

	render() {
		...
	}
}
```

위에서 주목해야 할 것은 `async`와 `await` 이다. 

async는 asynchronous의 줄임말로, 비동기적이라는 뜻을 가지고 있다. 쉽게 말하면 "코드를 순서대로 실행하지말고 일단 기다렸다가 실행해"라는 뜻이다. 그렇다면 뭘 기다리라는 건지에 대해 말해주는게 await가 되겠다. 즉, 위의 코드는 'axios가 url로부터 데이터를 받아오는 걸 기다려'라는 뜻이 된다. 참고로 await는 async 없이 쓸 수 없다. 

지금 상태에서의 movies는 다음 정보를 갖고 있다. 

0804_1

그래서 `console.log(movies)` 로 내용을 찍어봐도 위와 같이 나올 것이다. 

그렇다면 우리가 원하는 movies에는 어떻게 접근할 수 있을까? 

바로 아래와 같이 써줌으로써 movies에 접근할 수 있다. 

`console.log(movies.data.data.movies)` 

그런데 보기에 예쁘지가 않다는 생각이 확 든다. 그래서 조금 수정해줬다. 

```jsx
//before
	getMovies = async() => {
		const movies = await axios.get("~~~~");
	}

//after
	getMovies = async() => {
		const { data: { data: { movies }}} = await axios.get("~~~");
		console.log(movies);
	}
```

확실히 좀더 복잡한 형태를 띄지만 잘 생각해보면 axios가 얻어낸 정보 배열 안에서 data라는 배열 내 data라는 배열 내 movies라는 배열에 접근하는 것의 구조가 눈에 확 들어온다. 그리고 console.log 안에 들어가는 것 또한 그냥 movies로 매우 간단해졌다. 

### state 안에 movies를 선언하고 axios로 받아온 movies 정보를 넘기기.

우리가 getMovies를 통해 받아온 정보는 getMovies 안에서만 사용할 수 있다. 그러나 우리가 의도하는 것은 다른 곳에서도 movies의 내용에 접근하여 사용하는 것이다. 이를 위해 state에 `movies: []` 를 선언해주고, axios를 통해 받아온 정보를 해당 state 속  movies에 넘겨줄 것이다. 코드를 통해 살펴보자. 

```jsx
	getMovies = async() => {
		const { data: { data: { movies }}} = await axios.get("~~~");
		this.setState({movies: movies});
	}
```

위와 같이 써서 movies에 대한 정보를 가져온다. setState부분의 왼쪽 movies 는 state의 movies이고, 오른쪽의 movies는 const 내의 movies이다. 그리고 이것을 더욱 짧게 줄이는 것도 가능하다. 바로 이렇게 쓰는 것이다. 

`this.setState({ movies });`  

이를 통해 유추할 수 있는 것은 react가 state 내 필드 이름과 같은 것은 그냥 집어넣어버린다는 것이다.(setState에 한해)

## json 데이터를 컴포넌트에 넘겨서 render 시키는 연습하기.

axios를 통해 json api를 받아오는 것까지 성공했다. 이제 해당 정보를 컴포넌트에 넘겨서 사용해보자. 

먼저 Movies.js 파일을 새로 만들어서 내용을 다음과 같이 만들어보자 .

```jsx
import React from "react";
import PropTypes from "prop-types";

function Movie({id, year, title, summary, poster}) {
	return (
		<div className="movies__movie">
			<img src={poster} alt={title} title={title} />
			<h3 className="movie__title">{title}</h3>
			<h5 className="movie__year">{year}</h5>
			<p className="movie_summary">{summary}</p>
	//react에서는 class라는 키워드가 존재하기 때문에 특별히 className을 대신 써준다.
		</div>
	);
}

Movie.propTypes = {
	id: PropTypes.number.isRequired,
	year: PropTypes.number.isRequired,
	title: PropTypes.string.isRequired,
	summary: PropTypes.string.isRequired,
	poster: PropTypes.string.isRequired // medium_cover_image
}

export default Movie;
```

굳이 state를 쓸 필요가 없는 경우 function형을 사용하면 된다. 

Movie 컴포넌트를 만들었고, 해당 컴포넌트의 propTypes를 지정해주었다. 

해당 컴포넌트는 App.js에서 호출할 것이다. 

App.js에서는 다음과 같이 호출한다. 

```jsx
...
import Movie from "./Movie"; //필수!!

class App extends React.Component {
	...
	
	render() {
		const {isLoading, movies} = this.state;
		//위와 같이 써줌으로써 매번 this.state.movies로 접근할 필요 없이 바로 movies를 쓰게해줌.
		return <div>{isLoading ? "Loading..." : movies.map(){
				return <Movie //Movie 컴포넌트를 불러오는 부분.
                key = {movie.id} 
								//key는 항상 써주어야 한다. 
								//유일한 값을 가지는 걸로.
								//이 경우 id가 유일한 값이다.
								//안 써줘도 렌더링은 된다. 
                id = {movie.id} 
                year = {movie.year} 
                title = {movie.title} 
                summary = {movie.summary} 
                poster={movie.medium_cover_image}
                />
			}
		}</div>
	}
}
```
