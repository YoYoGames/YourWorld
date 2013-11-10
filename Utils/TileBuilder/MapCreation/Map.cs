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
        public int Width { get; set; }
        public int Height { get; set; }
        public int Depth { get; set; }
        public int LidBase { get; set; }
        public int Pavement { get; set; }

        // used in map generation
        public int Pavement2 { get; set; }
        public int Road { get; set; }
        public int Grass { get; set; }
        public int Water { get; set; }
        public int Field1 { get; set; }
        public int Field2 { get; set; }
        public int Field3 { get; set; }
        public int Residential { get; set; }
        public int Comercial { get; set; }
        public int Industrial { get; set; }
        

        public List<int>[] map;
        private Tile m_Tile;

        private Random rand = new Random(0x12441);


        public Map(int _width, int _height, int _depth, int _lidbase, int _pavement){
            Reset(_width,_height,_depth);
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
            Reset(_tile.Width, _tile.Height, 10);
            LidBase = 7;
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
        public void Reset(int _width, int _height, int _depth)
        {
            Width = _width;
            Height = _height;
            Depth = _depth;
            BlockInfo = new List<block_info>();
            FreeList = new Stack<int>();
            map = new List<int>[_width*_height];


            BlockInfo.Add(new block_info());            // block "0" is empty
            block_info b = new block_info();            // block "1" is pavement;
            b.Lid = Pavement;
            BlockInfo.Add(b);


            for (int y = 0; y < _height; y++)
            {
                int index = y*Width;
                for (int x = 0; x < _width; x++)
                {
                    map[x+index] = new List<int>();
                    map[x + index].Add(1);              // Build pavement at ground level
                    BlockInfo[1].Ref++;
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
            FreeList.Push(_b);
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
            List<int> column = map[_x + (_y * Width)];
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

            // If so, need a new block here....
            int nb = AllocBlock();

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
            List<int> column = map[_x + (_y * Width)];
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
            BlockInfo[ column[_z] ].Ref--;
            column[_z] = _block;
            BlockInfo[_block].Ref++;
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
            List<int> column = map[_x + (_y * Width)];
            if (column.Count <= _z) return;              // No need to compress

            int b = column[_z];
            block_info info = BlockInfo[b];       // get the block
            for (int i = 0; i < 6; i++)
            {
                if (info[i] != 0) return;
            }
            column[_z] = 0;
            FreeBlock(b);
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
            Set(_x, _y, _z, _block);
            int info_index = MakeUnique(_x,_y,_z);
            block_info info = BlockInfo[info_index];

            // Left
            int b = Get(_x - 1, _y, _z);
            if( b != -1 )
            {
                int newindex = MakeUnique(_x-1, _y, _z);
                BlockInfo[info_index].Right = -1;
                info.Left = -1;
                CompressBlock(_x - 1, _y, _z);
            }

            // Right
            b = Get(_x + 1, _y, _z);
            if (b != -1)
            {
                int newindex = MakeUnique(_x + 1, _y, _z);
                BlockInfo[info_index].Left = -1;
                info.Right = -1;
                CompressBlock(_x + 1, _y, _z);
            }

            // Top
            b = Get(_x, _y+1, _z);
            if (b != -1)
            {
                int newindex = MakeUnique(_x, _y+1, _z);
                BlockInfo[info_index].Bottom = -1;
                info.Top = -1;
                CompressBlock(_x, _y+1, _z);
            }

            // Bottom
            b = Get(_x, _y - 1, _z);
            if (b != -1)
            {
                int newindex = MakeUnique(_x, _y - 1, _z);
                BlockInfo[info_index].Top = -1;
                info.Bottom = -1;
                CompressBlock(_x, _y - 1, _z);
            }

            // Lid
            b = Get(_x, _y, _z+1);
            if (b != -1)
            {
                int newindex = MakeUnique(_x, _y, _z+1);
                BlockInfo[info_index].Base = -1;
                info.Lid = -1;
                CompressBlock(_x, _y, _z+1);
            }

            // Base
            b = Get(_x, _y, _z-1);
            if (b != -1)
            {
                int newindex = MakeUnique(_x, _y, _z-1);
                BlockInfo[info_index].Lid = -1;
                info.Base = -1;
                CompressBlock(_x, _y, _z - 1);
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
	    ///          	Create all the block infos we need to generate the map
	    ///          </summary>
	    // #############################################################################################
        private void BuildBlockInfos()
        {
            block_info b;

            Pavement = 7;         // pavement block
            Pavement2 = 11;
            Road = 3;
            Grass = 5;
            Water = 0;
            Field1 = 6;
            Field2 = 6;
            Field3 = 6;
            Residential = 1;
            Comercial = 6;
            Industrial = 0;


            // reset block info, and add space
            BlockInfo = new List<block_info>();
            AddBlockInfo( new block_info() );            // block "0" is empty


            b = new block_info();            // block "1" is pavement;
            b.Lid = Pavement;
            Pavement = AddBlockInfo(b);

            // Make a pavement2  block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Pavement2;
            Pavement2 = AddBlockInfo(b);

            // Make a road block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Road;
            Road = AddBlockInfo(b);

            // Make a grass block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Grass;
            Grass = AddBlockInfo(b);

            // Make a water block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Water;
            Water = AddBlockInfo(b);

            // Make a Field1 block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Field1;
            Field1 = AddBlockInfo(b);

            // Make a Field2 block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Field2;
            Field2 = AddBlockInfo(b);

            // Make a Field3 block
            b = new block_info();            // block "1" is pavement;
            b.Lid = Field3;
            Field3 = AddBlockInfo(b);

            // Make a Residential block (full cube)
            b = new block_info();            // block "1" is pavement;
            b.Lid = 14;                       // roof?
            b.Base = 14;                       // roof?
            b.Left = Residential;
            b.Right = Residential;
            b.Top = Residential;
            b.Bottom = Residential;
            Residential = AddBlockInfo(b);

            // Make a Comercial block (full cube)
            b = new block_info();            // block "1" is pavement;
            b.Lid = 13;                       // roof?
            b.Base = 14;                       // roof?
            b.Left = Comercial;
            b.Right = Comercial;
            b.Top = Comercial;
            b.Bottom = Comercial;
            Comercial = AddBlockInfo(b);

            // Make a Comercial block (full cube)
            b = new block_info();            // block "1" is pavement;
            b.Lid = 15;                       // roof?
            b.Base = 14;                       // roof?
            b.Left = Industrial;
            b.Right = Industrial;
            b.Top = Industrial;
            b.Bottom = Industrial;
            Industrial = AddBlockInfo(b);
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
        private void AddBuilding( int _x,int _y,int _col, int _min, int _max, int _block)
        {
            List<Coords> FinalList =  GetCoordList(_x, _y, (UInt32)_col );
            int h = rand.Next(_min, _max);
            foreach (Coords c in FinalList)
            {
                // Make a column of blocks
                Set(c.x, c.y, 0, Pavement);
                for (int i = 1; i <= h; i++)
                {
                    Add(c.x, c.y, i, _block);
                    //Set(c.x, c.y, i, _block);
                }
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
        public void Generate(  )
        {
            if (m_Tile == null) return;
            BuildBlockInfos();


            /*
            Pavement = 7;         // pavement block
            Pavement2 = 11;
            Road = 3;
            Grass = 5;
            Water = 0;
            Field1 = 6;
            Field2 = 6;
            Field3 = 6;
            Residential = 1;
            Comercial = 6;
            Industrial = 0;
             */
            int ResidentialMin = 2;
            int ResidentialMax = 4;

            int ComercialMin = 3;
            int ComercialMax = 9;

            int IndustrialMin = 2;
            int IndustrialMax = 5;

            // Now loop through the whole map and place a tile of the correct type IN the map
            for (int y = 0; y < Height; y++)
            {
                for (int x = 0; x < Width; x++)
                {
                    UInt32 col = m_Tile.GetPixel(x, y);
                    col &=0xffffff;
                    switch (col)
                    {
                        case 0x999999: Set(x, y, 0, Pavement); break;
                        case 0xcccccc: Set(x, y, 0, Pavement2); break;
                        case 0x404040: Set(x, y, 0, Road); break;
                        case 0x00cc33: Set(x, y, 0, Grass); break;
                        case 0x0094ff: Set(x, y, 0, Water); break;
                        case 0x009933: Set(x, y, 0, Field1); break;
                        case 0x947a4b: Set(x, y, 0, Field2); break;
                        case 0x99ff66: Set(x, y, 0, Field3); break;
                        case 0xffff00: AddBuilding(x,y, 0xffff00, ResidentialMin,ResidentialMax, Residential); break;
                        case 0x0033ff: AddBuilding(x, y, 0x0033ff, ComercialMin, ComercialMax, Comercial); break;
                        case 0xff0033: AddBuilding(x, y, 0xff0033, IndustrialMin, IndustrialMax, Industrial); break; 
                        //case 0x999999: Set(x, y, 0, Pavement); break;
                        //case 0x999999: Set(x, y, 0, Pavement); break;

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
                buff.Write((UInt16)64);
                buff.Write((UInt16)70);
                buff.Write((UInt16)Pavement);
                buff.Write((UInt16)8);


                // in RAW mode, just copy the buffer
                buff.Write((Byte)0);            // set no compression

                for (int y = 0; y < Height; y++)
                {
                    for (int x = 0; x < Width; x++)
                    {
                        List<int> column = map[x + (y * Width)];
                        buff.Write((UInt16)column.Count);
                        foreach (int i in column)
                        {
                            buff.Write((UInt32)i);
                        }
                    }
                }

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
