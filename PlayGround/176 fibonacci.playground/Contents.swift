var n = 5
var fiboarray = [0, 1]
var a = 0
var b = 1
var c : Int = 0
for x in 2...n {
    c = a + b
    fiboarray.append(c)
    a  = b
    b = c
}
print(fiboarray)
