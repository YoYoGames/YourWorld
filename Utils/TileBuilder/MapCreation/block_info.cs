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
        public int Left { get { return Faces[0]; } set { Faces[0] = value; } }
        public int Right { get { return Faces[1]; } set { Faces[1] = value; } }
        public int Top { get { return Faces[2]; } set { Faces[2] = value; } }
        public int Bottom { get { return Faces[3]; } set { Faces[3] = value; } }
        public int Lid { get { return Faces[4]; } set { Faces[4] = value; } }
        public int Base { get { return Faces[5]; } set { Faces[5] = value; } }

        public int Flags1 =0;
        public int Flags2 =0;


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



        public block_info()
        {
            Reset();
        }

        public void Reset()
        {
            for (int i = 0; i < 6; i++) Faces[i] = -1;
            Flags1 = 0;
            Flags2 = 0;
        }
    }
}
