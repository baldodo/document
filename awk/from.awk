function from(nb,   i,result)
{
    result=$nb
    for(i=nb+1;i<=NF;i++) {
       result=result" "$i
    }
    return result
}
