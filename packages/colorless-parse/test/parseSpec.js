const R = require('ramda');
const expect = require('chai').expect;

//const index = require('../src/index.js');
const { validateFunction, Error,  Ok } = require('../src/index.js');

describe("parsing validation:", () => {
    const hello = { n: 'hello', a: [], o: 'String', t: [], d: '' };
    it("no function", () => {
        expect(validateFunction({})).to.deep.equal(['error', ['missing name', 'missing output', 'missing arguments', 'missing tags', 'missing description']]);
    });
    it("simple function", () => {
        expect(validateFunction(hello)).to.deep.equal(['ok', hello]);
    });
    it("simple function - lower camel case error", () => {
        var hello2 = R.clone(hello);
        hello2.n = 'Hello';
        expect(validateFunction(hello2)).to.deep.equal(['error', ['lower camel case name']]);
    });
    it("simple function - invalid primitive output error", () => {
        var hello2 = R.clone(hello);
        hello2.o = 'asdf';
        expect(validateFunction(hello2)).to.deep.equal(['error', ['invalid primitive output']]);
    });
});
