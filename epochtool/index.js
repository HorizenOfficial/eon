
const STARTING_POINTS = {   //Do not modify this!! known starting points (based of Fork4). Format is [epochnumber, timestamp]
    "mainnet": [1213, 1702403700],  //Tue 12 Dec 2023 18:55 Milano time
    "gobi":    [1900, 1701181260], //Tue 28 Nov 11 2023 15:21 Milano time
    "pregobi": [1815, 1699876860], //Mon 13 Nov 2023 13:01 Milano time
}
const SLOT_IN_EPOCH = 15000;
const SLOT_DURATION = 3;

const DELTA = 10; //delta of +- 10 epochs 
const DELTA_SECONDS = DELTA * SLOT_IN_EPOCH * SLOT_DURATION;

var args = process.argv.slice(2);
if (args.length == 0){
    console.log("Usage: node index.js [network] [timestamp]");
    console.log("   [network] can value: mainnet, gobi, pregobi");
    console.log("   [timestamp] unix timestamp (in seconds) to query. Remove this parameter to use the current time");
    console.log("The tool will display the  epoch and slot of the timestamp, and the start of closest epochs, in a delta range of +- 10 epochs from the timestamp");
}else{
    var network = args[0];
    var timestamp =  args.length > 1 ? Number(args[1]) : Date.now()/1000;

    console.log("Calculating epoch starts for "+network);
    console.log("Requested date: "+ new Date(timestamp * 1000).toUTCString());
    console.log("   CURRENT date is: "+new Date().toUTCString()); 
    console.log("   CURRENT epoch/slot is: "+calculateCurrentEpochAndSlot(network));
    console.log("-----");
    var ret =  calculate(network, timestamp, false);
    for (var i = 0 ; i<ret.length; i++){
        var obj = ret[i];
        console.log(obj.time+"\t"+new Date(obj.time * 1000).toUTCString()+"\tEpoch: "+obj.epoch+"\tSlot: "+obj.slot +"\t"+(obj.closest? "***":""));
    }
}

function calculateCurrentEpochAndSlot(network){
    var res = calculate(network, Date.now()/1000, true);
    for (var i = 0 ; i<res.length; i++){
        if (res[i].closest){
            return res[i].epoch+"/"+res[i].slot;
        };
    }
}


export default function  calculate(network, timestamp, onlyCurrent){
    var knownPoint = STARTING_POINTS[network];
    if (knownPoint == null) {
        console.error("Unexpected network!");
    }
    var time = onlyCurrent ? knownPoint[1] : knownPoint[1] - DELTA_SECONDS;
    var epoch = onlyCurrent ? knownPoint[0] : knownPoint[0] - DELTA;

    var startWindow = onlyCurrent ? timestamp :  timestamp - DELTA_SECONDS;
    var endWindow = onlyCurrent ? timestamp :  timestamp + DELTA_SECONDS;
    var slot = 0;
    var found = false;
    var retObj =  [];
    if (timestamp < time){
        console.error("Timestamp is too old!");
    }else{
        while (time < endWindow){
            time = time + SLOT_DURATION;
            slot = slot + 1;
            if (slot == SLOT_IN_EPOCH){
                epoch = epoch  + 1;
                slot = 0;
            }
            if (time >= startWindow && (onlyCurrent || (!onlyCurrent && slot == 0))){
                var closest = false;
                if (!found && time >= timestamp){
                    found = true;
                    closest = true;
                }
                retObj.push({
                    time, epoch, slot, closest
                })
            }
        }       
    }
    return retObj;
}
