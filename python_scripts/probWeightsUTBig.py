#requires Python 2.7
#outputs a .m file in the directory in which it is run.
#use to generate unit tests for ProbWeight
import sys

def convertToA1(num):
    if num < 1:
        raise ValueError("num is less than 1: {0}".format(num))
    keyCodeLowBound = 65
    base = 26
    output = []
    while num:
        m = ((num-1)%base)
        num -= m
        num = num/base
        output.append(chr(keyCodeLowBound+m))
    return "".join(output[::-1])

sd = "\t-(void)testPW{0}{{\n"
lblNum = 0
bigS =""

def build_unit_test_body(weights,units,s,weightList):
    if weights == 2:
        for i2 in xrange(1,units):
            sPlusEnd =""
            strAssert =""
            weight2 = i2
            weight1 = units -i2
            lastChar1 = weights
            sPlusEnd+=(s+"\n\t\t[pw add:@\"{0}\" With:{1}];".format(convertToA1(lastChar1),weight1))
            lastChar2 = lastChar1 -1
            sPlusEnd+="\n\t\t[pw add:@\"{0}\" With:{1}];\n\n".format(convertToA1(lastChar2),weight2)
            lastSum = weightList[-1]["sum"] if len(weightList) else 0
            global total
            for i in xrange(total):
                strAssert+="\t\ts = [pw weightedRandomKey];\n"
                if i < lastSum:
                    for w in weightList:
                        if i < w["sum"]:
                            char = convertToA1(w["charCode"])
                            strAssert+="\t\tXCTAssert([s isEqualToString: @\"{0}\"]);//{1}\n".format(char,i)
                            break
                elif i < lastSum+weight1:
                    strAssert += "\t\tXCTAssert([s isEqualToString: @\"{0}\"]);//{1}\n".format(convertToA1(lastChar1),i)
                else:
                    strAssert += "\t\tXCTAssert([s isEqualToString: @\"{0}\"]);//{1}\n".format(convertToA1(lastChar2),i)
            global lblNum
            global bigS
            global sd
            lblNum+=1
            bigS += (sd.format(lblNum)+sPlusEnd+strAssert+"\n\t}\n\n")
    else:
        for iN in xrange(1,units):
            weightN = iN
            unitsN = units -iN
            sPlusN=(s+"\n\t\t[pw add:@\"{0}\" With:{1}];".format(convertToA1(weights),weightN))
            lastSum = weightList[-1]["sum"] if len(weightList) else 0
            lastSum+=weightN
            weightList.append({"sum":lastSum,"charCode":weights})
            build_unit_test_body(weights-1,unitsN,sPlusN,weightList)
            weightList.pop()
        return


def print_unit_tests(weights,units):
    if units < weights:
        raise ValueError("units is less than weights")
    global total
    total = units
    for iTop in xrange(1,units):
        sTop =""
        weightTop = iTop
        unitsNext = units - iTop
        sTop+="\t\tProbWeight *pw = [[ProbWeight alloc] init];\n"
        sTop+="\t\tNSString *s = @\"\";"
        sTop+="\n\t\t[pw add:@\"{0}\" With:{1}];".format(convertToA1(weights),weightTop)
        weightList = []
        weightList.append({"sum":weightTop,"charCode":weights})
        build_unit_test_body(weights-1,unitsNext,sTop,weightList)
        weightList.pop()
    return bigS
weightsNum = int(sys.argv[1])
unitsNum = int(sys.argv[2])
out = print_unit_tests(weightsNum,unitsNum)
with open("output.m","w") as text_file:
    text_file.write(out)
