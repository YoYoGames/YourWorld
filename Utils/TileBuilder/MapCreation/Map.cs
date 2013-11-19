// **********************************************************************************************************************
// 
// Copyright (c)2013, YoYo Games Ltd. All Rights reserved.
// 
// File:			Map.cs
// Created:			10/11/2013
// Author:			Mike
// Project:			TileBuilder
// Description:		YoYoCityEngine Map building tools
// 
// Date				Version		BY		Comment
// ----------------------------------------------------------------------------------------------------------------------
// 10/11/2013		V1.0.0      MJD     1st version, generate a map from a PNG
// 
// **********************************************************************************************************************
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TileBuilder.MapCreation
{
    class Map
    {
        const int CUT_SIDE = 8;
        const int CUT_TOP = 23;
        public class Coords
        {
            public int x;
            public int y;

            public Coords(int _x, int _y)
            {
                x = _x;
                y = _y;
            }
        }

        public List<block_info> BlockInfo;
        public Stack<int> FreeList;
        public Dictionary<uint, int> BlockCRCLookup;

        public int Width { get; set; }
        public int Height { get; set; }
        public int Depth { get; set; }
        public int LidBase { get; set; }
        public int Pavement { get; set; }

        // used in map generation
        public int Road { get; set; }
        public int Grass { get; set; }
        public int Water { get; set; }
        public int Field1 { get; set; }
        public int Field2 { get; set; }
        public int Field3 { get; set; }
        public int Concrete { get; set; }
        public int Airport { get; set; }
        public int AirportRunway { get; set; }
        public int MountainLow { get; set; }
        public int MountainMed { get; set; }
        public int MountainHigh { get; set; }
        public int Residential { get; set; }
        public int HighResidential { get; set; }
        public int Comercial { get; set; }
        public int Industrial { get; set; }

        public int GroundLevel = 3;
        public int TileWidth = 64;
        public int TileHeight = 64;

        public MapColumn[] map;
        private Tile m_Tile;

        private Random rand = new Random(0x12441);


        public Map(int _width, int _height, int _depth, int _lidbase, int _pavement){
            Reset(_width,_height,_depth,4);
            LidBase = _lidbase;
            Pavement = _pavement;
        }

	    // #############################################################################################
	    /// Constructor: <summary>
	    ///              	Create a map from a tile
	    ///              </summary>
	    ///
	    /// In:		<param name="_tile"></param>
	    ///
	    // #############################################################################################
        public Map(Tile _tile)
        {
            m_Tile = _tile;
            Reset(_tile.Width, _tile.Height, 16,4);
            LidBase = 12;
            Pavement = 7;
        }



	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Reset the map
	    ///          </summary>
	    ///
	    /// In:		<param name="_width"></param>
	    ///			<param name="_height"></param>
	    ///			<param name="_depth"></param>
	    ///
	    // #############################################################################################
        public void Reset(int _width, int _height, int _depth, int _groundlevel)
        {
            Width = _width;
            Height = _height;
            Depth = _depth;
            GroundLevel = _groundlevel;

            BlockCRCLookup = new Dictionary<uint, int>();
            BlockInfo = new List<block_info>();
            FreeList = new Stack<int>();
            map = new MapColumn[_width * _height];



            BlockInfo.Add(new block_info());            // block "0" is empty
            BlockInfo[0].Ref = 1;
            BlockInfo[0].UpdateCRC();
            BlockCRCLookup.Add(BlockInfo[0].CRC,0);


            BlockInfo.Add(new block_info());            // block "1" is "almost" empty
            BlockInfo[1].Ref = (_width * _height * GroundLevel) + 1; ;
            BlockInfo[1].Flags1|=0x80000000;
            BlockInfo[1].UpdateCRC();
            BlockCRCLookup.Add(BlockInfo[1].CRC,1);
            
            block_info b = new block_info();            // block "2" is pavement;
            b.Lid = Pavement;
            b.Ref = (_width * _height)+1;
            BlockInfo.Add(b);
            CheckDuplicate(2);



            for (int y = 0; y < _height; y++)
            {
                int index = y*Width;
                for (int x = 0; x < _width; x++)
                {
                    map[x + index] = new MapColumn();
                    for(int g=0;g<GroundLevel;g++){
                        map[x + index].Add(1);              // Water level has nothing by default
                    }
                    map[x + index].Add(2);                  // Build pavement at ground level (one block up)
                }
            }


        }

	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Allocate a block from our free list
	    ///          </summary>
	    ///
	    /// Out:	<returns>
	    ///				
	    ///			</returns>
	    // #############################################################################################
        public int AllocBlock()
        {
            if (FreeList.Count == 0)
            {
                int blk = BlockInfo.Count;
                BlockInfo.Add(new block_info());
                return blk;
            }
            return FreeList.Pop();
        }

	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Add a block to the free list
	    ///          </summary>
	    ///
	    /// In:		<param name="_b">block to free</param>
	    ///
	    // #############################################################################################
        public void FreeBlock(int _b)
        {
            BlockInfo[_b].Ref--;
            if (BlockInfo[_b].Ref == 0)
            {
                FreeList.Push(_b);
            }
        }


	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Get the column and expand it if required
	    ///          </summary>
	    ///
        /// In:		<param name="_x">x coordinate</param>
        ///			<param name="_y">y coordinate</param>
        ///			<param name="_z">z coordinate</param>
        /// Out:	<returns>
	    ///				The expanded column
	    ///			</returns>
	    // #############################################################################################
        public List<int> ExpandColumn(int _x,int _y,int _z)
        {
            // Expand the column to the length we need to reach _z
            List<int> column = map[_x + (_y * Width)].column;
            int l = column.Count;
            for (int i = (l - 1); i < _z; i++)
            {
                // Fill the column with block 0 (empty)
                column.Add(0);
                BlockInfo[0].Ref++;
            }
            return column;
        }

        // #############################################################################################
        /// Function:<summary>
        ///          	Set a block at x,y,z
        ///          </summary>
        ///
        /// In:		<param name="_x">x coordinate</param>
        ///			<param name="_y">y coordinate</param>
        ///			<param name="_z">z coordinate</param>
        ///			<param name="_tile">block to set</param>
        ///
        // #############################################################################################
        public int MakeUnique(int _x, int _y, int _z)
        {
            List<int> column = ExpandColumn(_x, _y, _z);
            int b = column[_z];

            // More than one block pointing at this one?
            if (BlockInfo[b].Ref ==1) return b;
            BlockInfo[b].Ref--;

            // If so, need a new block here....
            int nb = AllocBlock();
            BlockInfo[nb].Ref++;

            // Now copy the old info
            BlockInfo[nb].Copy(BlockInfo[b]);

            // And finally put the new, unique block into the world
            column[_z] = nb;
            return nb;
        }


        // #############################################################################################
        /// Function:<summary>
        ///          	Set a block at x,y,z
        ///          </summary>
        ///
        /// In:		<param name="_x">x coordinate</param>
        ///			<param name="_y">y coordinate</param>
        ///			<param name="_z">z coordinate</param>
        ///			<param name="_tile">block to set</param>
        ///
        // #############################################################################################
        public int Get(int _x, int _y, int _z)
        {
            if (_x < 0 || _x >= Width || _y< 0 || _y >= Height || _z<0) return -1;
            List<int> column = map[_x + (_y * Width)].column;
            if (column.Count <= _z) return -1;              // no block at that location
            return column[_z];
        }

        // #############################################################################################
        /// Function:<summary>
        ///          	Sets a block at x,y,z
        ///          </summary>
        ///
        /// In:		<param name="_x">x coordinate</param>
        ///			<param name="_y">y coordinate</param>
        ///			<param name="_z">z coordinate</param>
        ///			<param name="_block">block to set</param>
        ///
        // #############################################################################################
        public void Set(int _x, int _y, int _z, int _block)
        {
            List<int> column = ExpandColumn(_x, _y, _z);
            FreeBlock(column[_z]);
            column[_z] = _block;
            BlockInfo[_block].Ref++;
        }

	    // #############################################################################################
	    /// Function:<summary>
	    ///          	
	    ///          </summary>
	    ///
	    /// In:		<param name="_block"></param>
	    /// Out:	<returns>
	    ///				
	    ///			</returns>
	    // #############################################################################################
        public int CheckDuplicate(int _block)
        {
            block_info info = BlockInfo[_block];       // get the block
            bool NotSpace = false;
            for (int i = 0; i < 6; i++)
            {
                if (info[i] != -1)
                {
                    NotSpace = true;
                    break;;
                }
            }
            if (!NotSpace)
            {
                FreeBlock(_block);
                return 1;
            }

            // Now check the CRC lookup....
            BlockCRCLookup.Remove(info.CRC);

            // if its NOT a space, compare with all orther blocks
            uint crc = info.UpdateCRC();
            int newblock=-1;
            if( BlockCRCLookup.TryGetValue(crc, out newblock ) )
            {
                FreeBlock(_block);
                BlockInfo[newblock].Ref++;
                return newblock;
            }
            BlockCRCLookup.Add(crc, _block);
            return _block;
        }

	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Try and compress this location (match the block with others etc..)
	    ///          </summary>
	    ///
	    /// In:		<param name="_x"></param>
	    ///			<param name="_y"></param>
	    ///			<param name="_z"></param>
	    ///
	    // #############################################################################################
        public void CompressBlock(int _x,int _y,int _z)
        {
            List<int> column = map[_x + (_y * Width)].column;
            if (column.Count <= _z) return;              // No need to compress

            int b = column[_z];
            column[_z] = CheckDuplicate(b);
        }


        // #############################################################################################
        /// Function:<summary>
        ///          	Adds a block at x,y,z, making it unique if it has to
        ///          </summary>
        ///
        /// In:		<param name="_x">x coordinate</param>
        ///			<param name="_y">y coordinate</param>
        ///			<param name="_z">z coordinate</param>
        ///			<param name="_block">block to set</param>
        ///
        // #############################################################################################
        public void Add(int _x, int _y, int _z, int _block)
        {
            int info_index = MakeUnique(_x, _y, _z);
            block_info info = BlockInfo[info_index];
            info.Copy( BlockInfo[_block] );
            

            // Left
            int b = Get(_x - 1, _y, _z);
            if( b != -1 )
            {
                int newindex = MakeUnique(_x-1, _y, _z);
                BlockInfo[newindex].Right = -1;
                info.Left = -1;
                CompressBlock(_x - 1, _y, _z);
            }

            // Right
            b = Get(_x + 1, _y, _z);
            if (b != -1)
            {
                int newindex = MakeUnique(_x + 1, _y, _z);
                BlockInfo[newindex].Left = -1;
                info.Right = -1;
                CompressBlock(_x + 1, _y, _z);
            }

            // Bottom
            b = Get(_x, _y+1, _z);
            if (b != -1)
            {
                int newindex = MakeUnique(_x, _y+1, _z);
                BlockInfo[newindex].Top = -1;
                info.Bottom = -1;
                CompressBlock(_x, _y+1, _z);
            }

            // Top
            b = Get(_x, _y - 1, _z);
            if (b != -1)
            {
                int newindex = MakeUnique(_x, _y - 1, _z);
                BlockInfo[newindex].Bottom = -1;
                info.Top = -1;
                CompressBlock(_x, _y - 1, _z);
            }

            // Lid
            b = Get(_x, _y, _z+1);
            if (b != -1)
            {
                int newindex = MakeUnique(_x, _y, _z+1);
                BlockInfo[newindex].Base = -1;
                info.Lid = -1;
                CompressBlock(_x, _y, _z+1);
            }

            // Base
            b = Get(_x, _y, _z-1);
            if (b != -1)
            {
                int newindex = MakeUnique(_x, _y, _z-1);
                BlockInfo[newindex].Lid = -1;
                info.Base = -1;
                CompressBlock(_x, _y, _z - 1);
            }
            CompressBlock(_x, _y, _z);

        }


        // #############################################################################################
        /// Function:<summary>
        ///          	Delete a block at x,y,z, making it unique if it has to
        ///          </summary>
        ///
        /// In:		<param name="_x">x coordinate</param>
        ///			<param name="_y">y coordinate</param>
        ///			<param name="_z">z coordinate</param>
        ///			<param name="_block">block to set</param>
        ///
        // #############################################################################################
        public void Delete(int _x, int _y, int _z)
        {
            Set(_x, _y, _z, 0);

            // Left
            int b = Get(_x - 1, _y, _z);
            if (b >0 )
            {
                int newindex = MakeUnique(_x - 1, _y, _z);
                BlockInfo[newindex].Right = CUT_SIDE;
            }

            // Right
            b = Get(_x + 1, _y, _z);
            if (b > 0)
            {
                int newindex = MakeUnique(_x + 1, _y, _z);
                BlockInfo[newindex].Left = CUT_SIDE;
            }

            // Bottom
            b = Get(_x, _y + 1, _z);
            if (b > 0)
            {
                int newindex = MakeUnique(_x, _y + 1, _z);
                BlockInfo[newindex].Top = CUT_SIDE;
            }

            // Top
            b = Get(_x, _y - 1, _z);
            if (b > 0)
            {
                int newindex = MakeUnique(_x, _y - 1, _z);
                BlockInfo[newindex].Bottom = CUT_SIDE;
            }

            // Lid
            b = Get(_x, _y, _z + 1);
            if (b > 0)
            {
                int newindex = MakeUnique(_x, _y, _z + 1);
                BlockInfo[newindex].Base = CUT_TOP;
            }

            // Base
            b = Get(_x, _y, _z - 1);
            if (b > 0)
            {
                int newindex = MakeUnique(_x, _y, _z - 1);
                BlockInfo[newindex].Lid = CUT_TOP;
            }

        }


	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Add a block
	    ///          </summary>
	    ///
	    /// In:		<param name="_blk"></param>
	    ///
	    // #############################################################################################
        int AddBlockInfo(block_info _blk)
        {
            _blk.Ref++;
            int index = BlockInfo.Count;
            BlockInfo.Add(_blk);
            return index;
        }

	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Add a sprite to the map
	    ///          </summary>
	    ///
	    /// In:		<param name="_x"></param>
	    ///			<param name="_y"></param>
	    ///			<param name="_z"></param>
	    ///			<param name="_sprite"></param>
	    ///
	    // #############################################################################################
        void AddSprite(int _x, int _y, int _z, eSprite _sprite)
        {
            // First work out the cell we're in
            int gx = _x / TileWidth;
            int gy = _y / TileHeight;
            List<Sprite> column = map[gx + (gy * Width)].sprites;
            Sprite sp = new Sprite();
            sp.x = _x % TileWidth;
            sp.y = _y % TileHeight;
            sp.z = _z;
            sp.scale = 0;
            sp.flags = eSpriteFlags.none;
            sp.angle = 0;
            sp.SpriteType = _sprite;
            column.Add(sp);
        }



	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Create all the block infos we need to generate the map
	    ///          </summary>
	    // #############################################################################################
        private void BuildBlockInfos()
        {
            block_info b;

            Pavement = 7;         // pavement block
            Road = 3;
            Grass = 16;
            Water = 21;
            Field1 = 20;
            Field2 = 19;
            Field3 = 18;
            Concrete = 18;
            Residential = 7;
            Comercial = 6;
            Industrial = 2;
            Concrete = 17;
            Airport=10;
            AirportRunway=22;
            MountainLow=8;
            MountainMed=9;
            MountainHigh=10;
            HighResidential = 1;


            // Don't reset the map, REF counts are still valid
            //BlockInfo = new List<block_info>();
            //AddBlockInfo( new block_info() );            // block "0" is empty
            //b = new block_info();            // block "1" is pavement;
            //b.Lid = Pavement;
            //Pavement = AddBlockInfo(b);
            block_info p = BlockInfo[2];
            p.Lid = Pavement;
            Pavement = 2;


            // Make a road block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Road;
            Road = AddBlockInfo(b);
            CheckDuplicate(Road);

            // Make a grass block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Grass;
            Grass = AddBlockInfo(b);
            CheckDuplicate(Grass);

            // Make a water block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Water;
            Water = AddBlockInfo(b);
            CheckDuplicate(Water);

            // Make a Field1 block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Field1;
            Field1 = AddBlockInfo(b);
            CheckDuplicate(Field1);

            // Make a Field2 block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Field2;
            Field2 = AddBlockInfo(b);
            CheckDuplicate(Field2);

            // Make a Field3 block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Field3;
            Field3 = AddBlockInfo(b);
            CheckDuplicate(Field3);

            // Make a Residential block (full cube)
            b = new block_info();            // block "1" is pavement;
            b.Lid = 14;                       // roof?
            b.Base = 14;                       // roof?
            b.Left = Residential;
            b.Right = Residential;
            b.Top = Residential;
            b.Bottom = Residential;
            Residential = AddBlockInfo(b);
            CheckDuplicate(Residential);

            // Make a Comercial block (full cube)
            b = new block_info();            // block "1" is pavement;
            b.Lid = 13;                       // roof?
            b.Base = 14;                       // roof?
            b.Left = Comercial;
            b.Right = Comercial;
            b.Top = Comercial;
            b.Bottom = Comercial;
            Comercial = AddBlockInfo(b);
            CheckDuplicate(Comercial);

            // Make a Comercial block (full cube)
            b = new block_info();            // block "1" is pavement;
            b.Lid = 15;                       // roof?
            b.Base = 14;                       // roof?
            b.Left = Industrial;
            b.Right = Industrial;
            b.Top = Industrial;
            b.Bottom = Industrial;
            Industrial = AddBlockInfo(b);
            CheckDuplicate(Industrial);

            // Make a Concrete block 
            b = new block_info();            // block "1" is pavement;
            b.Lid = Concrete;                       // roof?
            Concrete = AddBlockInfo(b);
            CheckDuplicate(Concrete);

            // Make an Airport block (full cube)
            b = new block_info();            // block "1" is pavement;
            b.Lid = 26;                       // roof?
            b.Base = 23;                       // roof?
            b.Left = Airport;
            b.Right = Airport;
            b.Top = Airport;
            b.Bottom = Airport;
            Airport = AddBlockInfo(b);
            CheckDuplicate(Airport);

            // Make a AirportRunway block 
            b = new block_info();            // block "1" is pavement;
            b.Lid = AirportRunway;                       // roof?
            AirportRunway = AddBlockInfo(b);
            CheckDuplicate(AirportRunway);

            // Make an MountainLow block (full cube)
            b = new block_info();            // block "1" is pavement;
            b.Lid = 23;                       // roof?
            b.Base = 23;                       // roof?
            b.Left = MountainLow;
            b.Right = MountainLow;
            b.Top = MountainLow;
            b.Bottom = MountainLow;
            MountainLow = AddBlockInfo(b);
            CheckDuplicate(MountainLow);


            // Make an MountainLow block (full cube)
            b = new block_info();            // block "1" is pavement;
            b.Lid = 24;                       // roof?
            b.Base = 24;                       // roof?
            b.Left = MountainMed;
            b.Right = MountainMed;
            b.Top = MountainMed;
            b.Bottom = MountainMed;
            MountainMed = AddBlockInfo(b);
            CheckDuplicate(MountainMed);


            // Make an MountainLow block (full cube)
            b = new block_info();            // block "1" is pavement;
            b.Lid = 25;                       // roof?
            b.Base = 25;                       // roof?
            b.Left = MountainHigh;
            b.Right = MountainHigh;
            b.Top = MountainHigh;
            b.Bottom = MountainHigh;
            MountainHigh = AddBlockInfo(b);
            CheckDuplicate(MountainHigh);

            // Make an MountainLow block (full cube)
            b = new block_info();            // block "1" is pavement;
            b.Lid = 26;                        
            b.Base = 23;                       
            b.Left = HighResidential;
            b.Right = HighResidential;
            b.Top = HighResidential;
            b.Bottom = HighResidential;
            HighResidential = AddBlockInfo(b);
            CheckDuplicate(HighResidential);
            
        }

	    // #############################################################################################
	    /// Function:<summary>
	    ///          	"flood fills" a region so we get all connected points
	    ///          </summary>
	    ///
	    /// In:		<param name="_x"></param>
	    ///			<param name="_y"></param>
	    ///			<param name="_list"></param>
	    ///			<param name="check"></param>
	    /// Out:	<returns>
	    ///				
	    ///			</returns>
	    // #############################################################################################
        private List<Coords> GetCoordList(int _x, int _y, UInt32 _col )
        {
            Queue<Coords> _check = new Queue<Coords>();
            List<Coords> list = new List<Coords>();
            _check.Enqueue( new Coords(_x,_y) );
            m_Tile.SetPixel(_x, _y, 0);

            while (_check.Count != 0)
            {
                Coords point = _check.Dequeue();
                list.Add(point);
                if ((m_Tile.GetPixel(point.x - 1, point.y) & 0xffffff) == _col) { m_Tile.SetPixel(point.x - 1, point.y, 0); _check.Enqueue(new Coords(point.x - 1, point.y)); }
                if((m_Tile.GetPixel(point.x+1,point.y)&0xffffff)==_col) { m_Tile.SetPixel(point.x + 1, point.y, 0);_check.Enqueue(new Coords(point.x+1,point.y));}
                if((m_Tile.GetPixel(point.x,point.y-1)&0xffffff)==_col) { m_Tile.SetPixel(point.x, point.y - 1, 0);_check.Enqueue(new Coords(point.x,point.y-1));}
                if ((m_Tile.GetPixel(point.x, point.y + 1) & 0xffffff) == _col) { m_Tile.SetPixel(point.x, point.y + 1, 0); _check.Enqueue(new Coords(point.x, point.y + 1)); }
            }
            return list;
        }

	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Add a building at connected locations using _colour to identify on the map
        ///          	and make a the building between min and max sizes using _block as the block.
	    ///          </summary>
	    ///
	    /// In:		<param name="_x">X Coordinate</param>
	    ///			<param name="_y">y Coordinate</param>
	    ///			<param name="_col"></param>
	    ///			<param name="min"></param>
	    ///			<param name="_max"></param>
	    ///			<param name="_block"></param>
	    ///
	    // #############################################################################################
        private void AddBuilding( int _x,int _y, int _groundlevel, int _col, int _min, int _max, int _block)
        {
            List<Coords> FinalList =  GetCoordList(_x, _y, (UInt32)_col );
            int h = rand.Next(_min, _max);
            foreach (Coords c in FinalList)
            {
                // Make a column of blocks
                Set(c.x, c.y, _groundlevel, 1);
                for (int i = _groundlevel+1; i <= (_groundlevel+h); i++)
                {
                    Add(c.x, c.y, i, _block);
                }
            }
        }

        // #############################################################################################
        /// Function:<summary>
        ///          	Add a building at connected locations using _colour to identify on the map
        ///          	and make a the building between min and max sizes using _block as the block.
        ///          </summary>
        ///
        /// In:		<param name="_x">X Coordinate</param>
        ///			<param name="_y">y Coordinate</param>
        ///			<param name="_col"></param>
        ///			<param name="min"></param>
        ///			<param name="_max"></param>
        ///			<param name="_block"></param>
        ///
        // #############################################################################################
        private void AddTrees(int _x, int _y, int _groundlevel, int _col, eSprite _sprite)
        {
            List<Coords> FinalList = GetCoordList(_x, _y, (UInt32)_col);
            foreach (Coords c in FinalList)
            {
                Set(c.x / TileWidth, c.y / TileWidth, GroundLevel, Grass);
                int xx = rand.Next(-16,16);
                int yy = rand.Next(-16,16);
                AddSprite(c.x + 32+xx, c.y+32+yy, _groundlevel+16, _sprite);
            }
        }

	    // #############################################################################################
	    /// Function:<summary>
	    ///          	
	    ///          </summary>
	    ///
	    /// In:		<param name="_x"></param>
	    ///			<param name="_y"></param>
	    ///			<param name="_groundlevel"></param>
	    ///			<param name="_depth"></param>
	    ///
	    // #############################################################################################
        private void DigStack( int _x,int _y, int _groundlevel, int _min, int _max )
        {
            int h = rand.Next(_min, _max);
            for (int i = 0; i < h; i++)
            {
                Delete(_x, _y, _groundlevel - i);
            }

        }

        // #############################################################################################
        /// Function:<summary>
        ///          	Parse the image and create a map.
        ///          </summary>
        ///
        /// In:		<param name="_tile"></param>
        ///
        // #############################################################################################
        public void Generate()
        {
            if (m_Tile == null) return;

            Reset(m_Tile.Width, m_Tile.Height, 16,4);
            BuildBlockInfos();


            /*
            Pavement = 7;         // pavement block
            Road = 3;
            Grass = 5;
            Water = 0;
            Field1 = 6;
            Field2 = 6;
            Field3 = 6;
            Residential = 1;
            Comercial = 6;
            Industrial = 0;
            Concrete 
            Airport 
            AirportRunway
            MountainLow
            MountainMed
            MountainHigh 
             */
            int ResidentialMin = 1;
            int ResidentialMax = 3;

            int HighResidentialMin = 4;
            int HighResidentialMax = 12;

            int ComercialMin = 3;
            int ComercialMax = 12;

            int IndustrialMin = 2;
            int IndustrialMax = 4;

            int AirportMin = 3;
            int AirportMax = 4;

            int MountainLowMin = 3;
            int MountainLowMax = 7;
            int MountainMedMin = 7;
            int MountainMedMax = 10;
            int MountainHighMin = 10;
            int MountainHighMax = 14;

            //Delete(2, 2, GroundLevel);


            // First do all ground level tiles
            for (int y = 0; y < Height; y++)
            {
                for (int x = 0; x < Width; x++)
                {
                    UInt32 col = m_Tile.GetPixel(x, y);
                    col &= 0xffffff;
                    switch (col)
                    {
                        case 0x999999: Set(x, y, GroundLevel, Pavement); break;
                        case 0xcccccc: Set(x, y, GroundLevel, Concrete); break;
                        case 0x404040: Set(x, y, GroundLevel, Road); break;
                        case 0x00cc33: Set(x, y, GroundLevel, Grass); break;
                        //case 0x0094ff: Delete(x, y, GroundLevel); Delete(x, y, GroundLevel - 1); break; //, Water); break;
                        case 0x009933: Set(x, y, GroundLevel, Field1); break;
                        case 0x947a4b: Set(x, y, GroundLevel, Field2); break;
                        case 0x99ff66: Set(x, y, GroundLevel, Field3); break;
                        //case 0xff0033: AddBuilding(x, y, GroundLevel, 0xff0033, ResidentialMin, ResidentialMax, Residential); break;
                        //case 0x0033ff: AddBuilding(x, y, GroundLevel, 0x0033ff, ComercialMin, ComercialMax, Comercial); break;
                        //case 0xffff00: AddBuilding(x, y, GroundLevel, 0xffff00, IndustrialMin, IndustrialMax, Industrial); break;
                        case 0x666666: Set(x, y, GroundLevel, AirportRunway); break;
                    }
                }
            }


            // Now loop through the map and do anything which adds, or takes away
            for (int y = 0; y < Height; y++)
            {
                for (int x = 0; x < Width; x++)
                {
                    UInt32 col = m_Tile.GetPixel(x, y);
                    col &=0xffffff;
                    switch (col)
                    {
                        //case 0x999999: Set(x, y, GroundLevel, Pavement); break;
                        //case 0x404040: Set(x, y, GroundLevel, Road); break;
                        //case 0x00cc33: Set(x, y, GroundLevel, Grass); break;
                        case 0x0094ff: DigStack(x, y, GroundLevel, 3,3); break; // Delete(x, y, GroundLevel); Delete(x, y, GroundLevel - 1); break; //, Water); break;
                        //case 0x009933: Set(x, y, GroundLevel, Field1); break;
                        //case 0x947a4b: Set(x, y, GroundLevel, Field2); break;
                        //case 0x99ff66: Set(x, y, GroundLevel, Field3); break;
                        case 0xff0033: AddBuilding(x, y, GroundLevel, 0xff0033, ResidentialMin, ResidentialMax, Residential); break;
                        case 0x990000: AddBuilding(x, y, GroundLevel, 0x990000, HighResidentialMin, HighResidentialMax, HighResidential); break;
                        case 0x0033ff: AddBuilding(x, y, GroundLevel, 0x0033ff, ComercialMin, ComercialMax, Comercial); break;
                        case 0xffff00: AddBuilding(x, y, GroundLevel, 0xffff00, IndustrialMin, IndustrialMax, Industrial); break; 
                        //case 0x999999: Set(x, y, 0, Pavement); break;
                        //case 0x999999: Set(x, y, 0, Pavement); break;
                        case 0xff6600: AddBuilding(x, y, GroundLevel, 0xff6600, AirportMin, AirportMax, Airport); break;
                        case 0x99cccc: AddBuilding(x, y, GroundLevel, 0xffff00, MountainLowMin, MountainLowMax, MountainLow); break;
                        case 0xccffff: AddBuilding(x, y, GroundLevel, 0xffff00, MountainMedMin, MountainMedMax, MountainMed); break;
                        case 0xffffff: AddBuilding(x, y, GroundLevel, 0xffff00, MountainHighMin, MountainHighMax, MountainHigh); break;
                        case 0x006633: AddTrees(x * TileWidth, y * TileWidth, GroundLevel * TileWidth, 0xffff00, eSprite.Tree1); break; 

                    }
                }
            }
        }


	    // #############################################################################################
	    /// Function:<summary>
	    ///          	
	    ///          </summary>
	    ///
	    /// In:		<param name="_filename"></param>
	    ///
	    // #############################################################################################
        public void Save(string _filename)
        {
            Buffer buff = new Buffer(1024 * 1024 * 8);
            unchecked
            {
                buff.Write((UInt32)3);
                buff.Write((UInt32)0);       // spare space.
                buff.Write((UInt32)0);
                buff.Write((UInt32)0);
                buff.Write((UInt32)0);
                buff.Write((UInt32)0);
                buff.Write((UInt32)0);
                buff.Write((UInt32)0);
                buff.Write((UInt32)0);
                buff.Write((UInt16)Width);
                buff.Write((UInt16)Height);
                buff.Write((UInt16)Depth);
                buff.Write((UInt16)0);
                buff.Write((UInt16)LidBase);
                buff.Write((UInt16)TileWidth);
                buff.Write((UInt16)70);
                buff.Write((UInt16)Pavement);
                buff.Write((UInt16)16);


                // in RAW mode, just copy the buffer
                buff.Write((Byte)0);            // set no compression
                int sprite_count = 0;
                for (int y = 0; y < Height; y++)
                {
                    for (int x = 0; x < Width; x++)
                    {
                        // Write out block column
                        List<int> column = map[x + (y * Width)].column;
                        List<Sprite> sprites = map[x + (y * Width)].sprites;
                        int flags = 0;
                        if (sprites.Count != 0) flags |= 0x8000;

                        
                        // Top bit set IF there are sprites in this column
                        buff.Write((UInt16)(column.Count | flags));
                        foreach (int i in column)
                        {
                            buff.Write(((UInt16)(i & 0xffff)));
                            buff.Write( ((Byte) ((i>>16)&0xff)) );
                        }


                        if (sprites.Count != 0)
                        {
                            // If we have sprites here, save them out...
                            buff.Write((UInt16)sprites.Count);
                            foreach (Sprite s in sprites)
                            {
                                buff.Write((UInt16) ((int)s.SpriteType & 0xffff) );
                                UInt32 pos = (UInt32)((s.x & 0xff) | ((s.y & 0xff) << 8) | ((s.z & 0xffff) << 16));
                                buff.Write((UInt32)pos);
                                buff.Write((UInt32)0);
                                sprite_count++;
                            }
                            if (sprites.Count != 1)
                            {
                                Console.WriteLine("HERE!");
                            }
                        }

                    }
                }

                Console.WriteLine("Sprites = " + sprite_count.ToString());
                Console.WriteLine("BlockInfos = " + BlockInfo.Count.ToString());
                // Write out number of block info structs we have    
                buff.Write((UInt32)BlockInfo.Count);
                foreach (block_info info in BlockInfo)
                {
                    for (int i = 0; i < 6; i++)
                    {
                        buff.Write((UInt16)info[i]);
                    }
                    buff.Write(((UInt32)info.Flags1));
                    buff.Write((UInt32)info.Flags1);
                }
            }

            buff.Save(_filename);

        }



    }
}
