var list=argument0;
var newline=argument1;
var dist=argument2;
for(var i=0;i<global.linecount;i++){

    var l = ds_list_find_value(list,i);
    // Must be both in the same direction ([4] = horizontal flag)
    if(l[4]==newline[4]){
        if(l[0]!=l[2]){
            var cx,cy,d1,d2,xx;
            d1 = (l[2]-l[0])/2;
            c1 = d1+l[0];
            d2 = (newline[2]-newline[0])/2;
            c2 = d2+newline[0];
            d3 = abs(c1-c2);
            if( d3<(d1+d2) )
            {
                if( abs(l[1]-newline[1])<dist ) return false;            
            }
        }else{
            d1 = (l[3]-l[1])/2;
            c1 = d1+l[1];
            d2 = (newline[3]-newline[1])/2;
            c2 = d2+newline[1];
            d3 = abs(c1-c2);
            if( d3<(d1+d2) )
            {
                if( abs(l[0]-newline[0])<dist ) return false;            
            }
        }
    }
}
return true;
