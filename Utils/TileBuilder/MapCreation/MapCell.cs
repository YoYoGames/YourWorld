using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TileBuilder.MapCreation
{
    public enum eSprites
    {
        None = 0,
        Tree1,
        Bush1,
    };

    public class SpriteList
    {
        public eSprites    SpriteType;
        
        // these only need to be 24bit
        public int x;       
        public int y;
        public int z;
    }


    public class MapCell
    {
        public int Tile;

    }
}
