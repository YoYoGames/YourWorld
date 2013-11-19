using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TileBuilder.MapCreation
{
    public enum eSprite
    {
        None = 0,
        //Tree group
        Tree1,
        // bush group
        Bush1,
        // stall group
        Stall1
    };

    [Flags]
    public enum eSpriteFlags
    {
        none = 0,
        flipx = 0x00000001,
        flipy = 0x00000002
    };

    // #############################################################################################
    /// Class:<summary>
    ///       	A sprite
    ///       </summary>
    ///       <remarks>
    ///       
    ///       </remarks>
    // #############################################################################################
    public class Sprite
    {
        public eSprite    SpriteType;
        
        // these only need to be 24bit
        public int x;           // -127  to +128 (offset into tile)
        public int y;           // ditto
        public int z;           // 0 to 65536 (0 to 1024*64)
        public float scale;     // x and y scales are the same
        public float angle;
        public eSpriteFlags flags;
    }


    public class MapColumn
    {
        public List<int> column = new List<int>();
        public List<Sprite> sprites = new List<Sprite>();

        public void Add(int _tile)
        {
            column.Add(_tile);
        }

        public void AddSprite(eSprite _spr, int _x, int _y, int _z, float _scale, float _angle, eSpriteFlags _flags)
        {
            Sprite spr = new Sprite();
            spr.x = _x & 0xff;
            spr.y = _y & 0xff;
            spr.z = _z & 0x3ff;
            spr.scale = _scale;
            spr.angle = _angle;
            spr.flags = _flags;
            sprites.Add(spr);
        }
    }

}
