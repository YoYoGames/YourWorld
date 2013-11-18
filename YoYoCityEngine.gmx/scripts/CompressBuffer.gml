/// CompressBuffer(src_buffer,size,dest_buffer)
//
/// Compress (simple byte-run) the buffer provided. 
/// Dest buffer must be at the correct spot for storage
///
/// CompressBuffer( src, size, dest )
///
_src  = argument0;
_size = argument1;
_dest = argument2;
       
    var len = buffer_tell(raw);
    var i=0;
    while(i<len-3)
    {
        var pos = buffer_tell(_src);
        var cnt=1;
        var byte = buffer_read( _src, buffer_u8 );
        while(cnt<128){
            var a=buffer_read(_src,buffer_u8);
            if(a==byte) {
                cnt++;
            }else{
                buffer_seek(_src,buffer_seek_relative,-1);  // back 1 byte
                break;
            }
        }
        
        // worth storing the run?
        if(cnt>=3){
            buffer_write(_dest,buffer_u8,cnt);  // store fill count
            buffer_write(_dest,buffer_u8,byte); // store byte to fill with            
        }else{
            // if not - or if we didn't HAVE a fill, then count copy bytes
            var wpos=buffer_tell(_dest);        // remember counter pos
            buffer_write(_dest,buffer_u8,0);    // store empty counter for no
            
            // Move back to start of test            
            buffer_seek(_src, buffer_seek_start, pos );

            var cnt = 0;
            var b1,b2,b3;
            b1 = buffer_read(_src,buffer_u8);
            b2 = buffer_read(_src,buffer_u8);
            b3 = buffer_read(_src,buffer_u8);
            while(cnt<127){
                // found a run?
                if( (b1==b2) && (b2==b3) ){
                    break;
                }
                buffer_write(_dest,buffer_u8,b1);
                b1=b2;
                b2=b3;
                b3 = buffer_read(_src,buffer_u8);
                cnt++;
            }
            if( cnt==127 ){
                buffer_seek(_src, buffer_seek_relative, -2 );
            }
            if( cnt!=0 ){
                //seek
            }                        
        }
    
    }
    
    
    
