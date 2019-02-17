# Node.js

## Tips

- async/await mode only works for with promises
- Async/await can be used before a callback function, for example

```js
...
return callbackFunction(async (response) => {
  var restult = await anotherCallbackFunction;
});
...
```

reference: https://medium.com/front-end-weekly/modern-javascript-and-asynchronous-programming-generators-yield-vs-async-await-550275cbe433

- debug:  `node --inspect app.js` or https://nodejs.org/dist/latest-v5.x/docs/api/debugger.html


## Unit Test

- Install mock-related libraries in dev mode.

```sh
npm install --save-dev library-name
mocha --timeout 120000 xxxx --exit
```

## Integration Test
