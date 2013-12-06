// **********************************************************************************************************************
// 
// Copyright (c)2013, YoYo Games Ltd. All Rights reserved.
// 
// File:			block_info.cs
// Created:			10/11/2013
// Author:			Mike
// Project:			TileBuilder
// Description:		A block information structure
// 
// Date				Version		BY		Comment
// ----------------------------------------------------------------------------------------------------------------------
// 10/11/2013		V1.0.0      MJD     1st version
// 06/11/2013		V1.0.1      MJD     Updated to map format V4
// 
// **********************************************************************************************************************
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TileBuilder.MapCreation
{
    // #############################################################################################
    /// Class:<summary>
    ///       	Holds a block information structure
    ///       </summary>
    // #############################################################################################
    class block_info
    {
        private int[] Faces = new int[6];
        public int Left { get { return Faces[0]; } set { Faces[0] = value;  } }
        public int Right { get { return Faces[1]; } set { Faces[1] = value; } }
        public int Top { get { return Faces[2]; } set { Faces[2] = value;  } }
        public int Bottom { get { return Faces[3]; } set { Faces[3] = value;  } }
        public int Lid { get { return Faces[4]; } set { Faces[4] = value;  } }
        public int Base { get { return Faces[5]; } set { Faces[5] = value;  } }
        public int Ref;

        // Flags1       = %x000000000ILST555444333222111000  (face 000= RHV =Rotate90, Flip-Horizontal, Flip-Vertical)
        //                face 0=top,1=bottom,2=left,3=right,4=lid,5=base
        //                T = flatten TOP+BOTTOM
        //                S = Flatten SIDES (left/right)
        //                L = flatten LID+BASE
        //                I = invert faces (not yet implemented)
        //                x = reserved for saving extended block info
        public uint Flags1 =0;
        public uint Flags2 =0;

        // BLK_OFFSETS1 = %2222_2222/1111_1111_1111/0000_0000_0000     number = 0,1,2,3,4,5,6,7 = vertex index
        // BLK_OFFSETS2 = %5555/4444_4444_4444/3333_3333_3333/2222     0000_0000_0000 = x,y,z offsets. 16 per direction. 
        // BLK_OFFSETS3 = %7777_7777_7777/6666_6666_6666/5555_5555     (64pix = 16 offsets)
        public uint Offsets1 = 0x00000000;
        public uint Offsets2 = 0x00000000;
        public uint Offsets3 = 0x00000000;

        private uint m_CRC=0xffffffff;
        public uint CRC { get { return m_CRC; } set { m_CRC = value; } }

	    // #############################################################################################
	    /// Property: <summary>
	    ///           	Face access as an array
	    ///           </summary>
	    // #############################################################################################
        public int this[int index]
        {
            get
            {
                return Faces[index];
            }
            set
            {
                Faces[index] = value;
            }
        }

	    // #############################################################################################
	    /// Constructor: <summary>
	    ///              	Create a new block by copying another one - except the Ref.
	    ///              </summary>
	    ///
	    /// In:		<param name="_src">Source block tocopy</param>
	    ///
	    // #############################################################################################
        public block_info(block_info _src)
        {
            Copy(_src);
            Ref = 0;
        }

	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Copy the given block details into this block. Does not effect Ref.
	    ///          </summary>
	    ///
	    /// In:		<param name="_src"></param>
	    ///
	    // #############################################################################################
        public void Copy(block_info _src)
        {
            for (int i = 0; i < 6; i++)
            {
                Faces[i] = _src[i];
            }
            Flags1 = _src.Flags1;
            Flags2 = _src.Flags2;
        }
	    // #############################################################################################
	    /// Constructor: <summary>
        ///              	Create an "empty" block
	    ///              </summary>
	    // #############################################################################################
        public block_info()
        {
            Reset();
        }

	    // #############################################################################################
	    /// Constructor: <summary>
	    ///              	Reset a block back to empty - with no ref
	    ///              </summary>
	    // #############################################################################################
        public void Reset()
        {
            for (int i = 0; i < 6; i++) Faces[i] = -1;
            Flags1 = 0;
            Flags2 = 0;
            Ref = 0;
        }


	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Take a CRC of the tile
	    ///          </summary>
	    ///
	    /// Out:	<returns>
	    ///				
	    ///			</returns>
	    // #############################################################################################
        public uint UpdateCRC()
        {
            uint crc=0xffffffff;
            for(int i=0;i<6;i++){
                crc = CRC32.CRC(Faces[i], crc);
            }
            crc = CRC32.CRC(Flags1, crc);
            crc = CRC32.CRC(Flags2, crc);
            crc = CRC32.CRC(Offsets1, crc);
            crc = CRC32.CRC(Offsets2, crc);
            crc = CRC32.CRC(Offsets3, crc);
            m_CRC = crc;
            return m_CRC;
        }
    }
}
