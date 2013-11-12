using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TileBuilder
{
    class CRC32
    {
        private static uint[] ms_fastCRC = null;


        // #############################################################################################
        /// Function:<summary>
        ///				Build a CRC table - must be called before any namespaces are setup...
        ///			</summary>
        ///
        /// Out:	<returns>
        ///				The CRC lookup table
        ///			</returns>
        // #############################################################################################
        private static uint[] InitFastCRC()
        {
            if (ms_fastCRC == null)
            {
                uint uCRC, uPoly;
                uint i, j;

                uint[] uCRCTable = new uint[256];

                uPoly = 0xEDB88320;
                for (i = 0; i < 256; i++)
                {
                    uCRC = i;
                    for (j = 8; j > 0; j--)
                    {
                        if ((uCRC & 1) != 0)
                            uCRC = (uCRC >> 1) ^ uPoly;
                        else
                            uCRC >>= 1;
                    }
                    uCRCTable[i] = uCRC;
                }
                ms_fastCRC = uCRCTable;
            } // end if
            return ms_fastCRC;
        }

        // #############################################################################################
        /// Function:<summary>
        ///				Gets the CRC for the string with 8bit ASCII option.
        ///			</summary>
        ///
        /// In:		<param name="_text">Actual text to get a CRC for</param>
        /// 		<param name="_ASCII">Calc CRC for 8bit text only (ignores 2nd byte)</param>
        /// Out:	<returns>
        ///				The whole text CRC
        ///			</returns>
        // #############################################################################################
        public static uint CalcCRC(string _text)
        {
            uint[] table = InitFastCRC();
            uint crc = 0xFFFFFFFF;

            foreach (char c in _text)
            {
                crc = ((crc >> 8) & 0x00FFFFFF) ^ table[(crc ^ (c & 0xff)) & 0xFF];
                crc = ((crc >> 8) & 0x00FFFFFF) ^ table[(crc ^ ((((int)c) >> 8) & 0xff)) & 0xFF];
            }

            return crc;
        }

        // #############################################################################################
        /// Function:<summary>
        ///             
        ///          </summary>
        ///
        /// In:		 <param name="_buffer"></param>
        /// Out:	 <returns>
        ///				
        ///			 </returns>
        // #############################################################################################
        public static int CalcCRC(byte[] _buffer)
        {
            uint[] table = InitFastCRC();
            uint crc = 0xFFFFFFFF;

            foreach (byte b in _buffer)
            {
                crc = ((crc >> 8) & 0x00FFFFFF) ^ table[(crc ^ b) & 0xFF];
            }

            return unchecked((int)crc);
        }

        // #############################################################################################
        /// Function:<summary>
        ///             
        ///          </summary>
        ///
        /// In:		 <param name="_buffer"></param>
        /// Out:	 <returns>
        ///				
        ///			 </returns>
        // #############################################################################################
        public static uint CalcCRC(byte[] _buffer, int offset)
        {
            uint[] table = InitFastCRC();
            uint crc = 0xFFFFFFFF;
            int i;

            for (i = offset; i < _buffer.Length; i++)
            {
                crc = ((crc >> 8) & 0x00FFFFFF) ^ table[(crc ^ _buffer[i]) & 0xFF];
            }

            return crc;
        }

	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Process a CRC. 
	    ///          </summary>
	    ///
	    /// In:		<param name="_value"></param>
        ///     	<param name="_crc">current CRC value, of 0xFFFFFFFF to start</param>
        /// Out:	<returns>
	    ///				New CRC value
	    ///			</returns>
	    // #############################################################################################
        public static uint CRC(Byte _value, uint _crc )
        {
            uint[] table = InitFastCRC();
            uint crc = _crc; // 0xFFFFFFFF;

            crc = ((crc >> 8) & 0x00FFFFFF) ^ table[(crc ^ _value) & 0xFF];
            return crc;
        }
        public static uint CRC(Byte _value)
        {
            return CRC(_value, 0xFFFFFFFF);
        }
        public static uint CRC(UInt16 _value, uint _crc)
        {
           uint crc = CRC((Byte) (_value & 0xff), _crc);
           return CRC((Byte)((_value>>8) & 0xff), crc);
        }
        public static uint CRC(UInt32 _value, uint _crc)
        {
            uint crc = CRC((Byte)(_value & 0xff), _crc);
            crc = CRC((Byte)((_value >> 8) & 0xff), crc);
            crc = CRC((Byte)((_value >> 16) & 0xff), crc);
            return CRC((Byte)((_value >> 24) & 0xff), crc);
        }

        public static uint CRC(int _value, uint _crc)
        {
            unchecked
            {
                return CRC((uint)_value, _crc);
            }

        }
    }
}
