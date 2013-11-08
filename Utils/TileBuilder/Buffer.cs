using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TileBuilder
{
    class Buffer
    {
        Byte[] Data;
        int Head;

	    // #############################################################################################
	    /// Constructor: <summary>
	    ///              	Create a new buffer
	    ///              </summary>
	    ///
	    /// In:		<param name="_size">size of inital buffer</param>
	    ///
	    // #############################################################################################
        public Buffer(int _size)
        {
            Data = new byte[_size];
            Head = 0;
        }


	    // #############################################################################################
	    /// Constructor: <summary>
	    ///              	
	    ///              </summary>
	    ///
	    /// In:		<param name="_value"></param>
	    ///
	    // #############################################################################################
        public void Write( Byte _value )
        {
            // resize?
            if( Head>=Data.Length ){
                Byte[] NewArray = new Byte[Data.Length+(Data.Length/4)];
                Data.CopyTo(NewArray,0);
                Data = NewArray;
            }
            Data[Head++]=_value;
        }


        public void Write( UInt32 _value )
        {
            unchecked
            {
                Write((Byte)(_value & 0xff));
                Write((Byte)((_value >> 8) & 0xff));
                Write((Byte)((_value >> 16) & 0xff));
                Write((Byte)((_value >> 24) & 0xff));
            }
        }
        public void Write(UInt16 _value)
        {
            unchecked
            {
                Write((Byte)(_value & 0xff));
                Write((Byte)((_value >> 8) & 0xff));
            }
        }
        public void Write(Int16 _value)
        {
            unchecked
            {
                Write((Byte)(_value & 0xff));
                Write((Byte)((_value >> 8) & 0xff));
            }
        }
        public void Write(int _value)
        {
            unchecked
            {
                Write((Byte)(_value & 0xff));
                Write((Byte)((_value >> 8) & 0xff));
                Write((Byte)((_value >> 16) & 0xff));
                Write((Byte)((_value >> 24) & 0xff));
            }
        }

        public void Save(string _filename)
        {
            Byte[] File = new Byte[Head];
            Array.Copy(Data, File, Head);
            System.IO.File.WriteAllBytes(_filename, File);
        }
    }
}
