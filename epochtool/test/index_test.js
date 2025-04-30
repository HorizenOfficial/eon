import { expect } from "chai";
import calculate from "../index.js";

describe("Main test", () =>  {
  it("should return correct epochs for F6Fork", async () => {
    expect(findClosest(calculate("pregobi",1716301860)).epoch).to.equal(2180);
    expect(findClosest(calculate("gobi",1718011260)).epoch).to.equal(2274);
    expect(findClosest(calculate("mainnet",1719503700)).epoch).to.equal(1593);
  });
  it("should return correct epochs for F5Fork", async () => {
    expect(findClosest(calculate("pregobi",1708516860)).epoch).to.equal(2007);
    expect(findClosest(calculate("gobi",1710226260)).epoch).to.equal(2101);
    expect(findClosest(calculate("mainnet",1711043700)).epoch).to.equal(1405);
  });
  
});

function findClosest(res){
    for (var i = 0 ; i<res.length; i++){
        if (res[i].closest){
            return res[i];
        };
    }
}