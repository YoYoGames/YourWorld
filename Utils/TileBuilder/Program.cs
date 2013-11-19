// **********************************************************************************************************************
// 
// Copyright (c)2013, YoYo Games Ltd. All Rights reserved.
// 
// File:			Program.cs
// Created:			30/10/2013
// Author:			Mike
// Project:			TileBuilder
// Description:		Reads in a list of tiles and builds a tilemap PNG file, complete with edge smearing.
//                  If a single PNG, will generate a map (.city file) from it.
// 
// Date				Version		BY		Comment
// ----------------------------------------------------------------------------------------------------------------------
// 30/10/2013		V1.0.0      MJD     1st version.
// 05/11/2013		V1.0.1      MJD     Map generation added
// 12/11/2013		V1.0.2      MJD     Fixed tile generation bug
// 
// **********************************************************************************************************************
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Windows.Forms;
using System.Drawing;
using System.Drawing.Imaging;
using TileBuilder.MapCreation;

namespace TileBuilder
{
    class Program
    {
        const int CORE_TILEWIDTH = 64;
        const int CORE_TILEHEIGHT = 64;
        const int BORDER_SIZE = 3;

        /// <summary>border+Tile+border width</summary>
        const int TILEWIDTH = BORDER_SIZE + CORE_TILEWIDTH + BORDER_SIZE;
        /// <summary>border+Tile+border height</summary>
        const int TILEHEIGHT = BORDER_SIZE + CORE_TILEHEIGHT + BORDER_SIZE;

        /// <summary>Texture width in pixels</summary>
        public static int TWIDTH = 2048;
        /// <summary>Texture height in pixels</summary>
        public static int THEIGHT = 1024;
        /// <summary>Number if tiles per row</summary>
        public static int TROW = TWIDTH / TILEWIDTH;

        public static UInt32 NumTiles = 0;

        public static List<Tile> Tiles = new List<Tile>();



	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Add the "clamp" region around the tile
	    ///          </summary>
	    ///
	    /// In:		<param name="_Texture">Raw Texture page</param>
	    ///			<param name="_dest">Index of the top left pixel of the tile</param>
        ///			<param name="_clampx">border width</param>
	    ///			<param name="_clampy">border height</param>
	    ///
	    // #############################################################################################
        public static void AddWrapping(UInt32[] _Texture, int _dest, int _clampx, int _clampy)
        {
            // get real base of tile
            int tilebase = _dest - (_clampy*TWIDTH)-_clampx;
            int src = _dest;
         

            // First the corner squares

            // Do top left corner
            UInt32 pixel = _Texture[src];
            for (int y = 0; y < _clampy; y++)
            {
                for (int x = 0; x < _clampx; x++)
                {
                    _Texture[tilebase + x + (y * TWIDTH)] = pixel;
                }
            }

            // Do top right corner
            tilebase = _dest - (_clampy * TWIDTH) + 64 ;
            pixel = _Texture[src + 63];
            for (int y = 0; y < _clampy; y++)
            {
                for (int x = 0; x < _clampx; x++)
                {
                    _Texture[tilebase + x + (y * TWIDTH)] = pixel;
                }
            }

            // Do bottom right corner
            tilebase = _dest + 64 + (64*TWIDTH);
            pixel = _Texture[src + 63 + (63*TWIDTH)];
            for (int y = 0; y < _clampy; y++)
            {
                for (int x = 0; x < _clampx; x++)
                {
                    _Texture[tilebase + x + (y * TWIDTH)] = pixel;
                }
            }

            // Do bottom left corner
            tilebase = _dest - _clampx + (64 * TWIDTH);
            pixel = _Texture[src + (63 * TWIDTH)];
            for (int y = 0; y < _clampy; y++)
            {
                for (int x = 0; x < _clampx; x++)
                {
                    _Texture[tilebase + x + (y * TWIDTH)] = pixel;
                }
            }

            // Now the rows....


            // Do top row
            tilebase = _dest - ( _clampy * TWIDTH);
            for (int y = 0; y < _clampy; y++)
            {
                for (int x = 0; x < 64; x++)
                {
                    pixel = _Texture[src + x];
                    _Texture[tilebase + x + (y * TWIDTH)] = pixel;
                }
            }

            // Do bottom row
            tilebase = _dest + (64 * TWIDTH);
            for (int y = 0; y < _clampy; y++)
            {
                for (int x = 0; x < 64; x++)
                {
                    pixel = _Texture[src + x + (63*TWIDTH)];
                    _Texture[tilebase + x + (y * TWIDTH)] = pixel;
                }
            }


            // Do left row
            tilebase = _dest - _clampx;
            for (int y = 0; y < 64; y++)
            {
                for (int x = 0; x < _clampx; x++)
                {
                    pixel = _Texture[src + (y * TWIDTH)];
                    _Texture[tilebase + x + (y * TWIDTH)] = pixel;
                }
            }

            // Do right row
            tilebase = _dest + 64;
            for (int y = 0; y < 64; y++)
            {
                for (int x = 0; x < _clampx; x++)
                {
                    pixel = _Texture[src + 63 + (y * TWIDTH)];
                    _Texture[tilebase + x + (y * TWIDTH)] = pixel;
                }
            }
        }



        // #############################################################################################
        /// Function:<summary>
        ///          	Add a tile to the new texture page
        ///          </summary>
        ///
        /// In:		<param name="_tile">Tile to add</param>
        ///			<param name="_Texture">Texture page UINT32 array</param>
        ///			<param name="_dest">base index into texture</param>
        ///
        // #############################################################################################
        public static unsafe void AddTile(Tile _tile, UInt32[] _Texture, int _dest)
        {
            int DestBase = _dest;

            UInt32[] TileData = _tile.TileData;
            for (int y = 0; y < _tile.Height; y++)
            {
                for (int x = 0; x < _tile.Width; x++)
                {
                    _Texture[_dest + x] = TileData[(_tile.Width*y)+ x];
                }
                _dest += TWIDTH;
            }

            AddWrapping(_Texture, DestBase, BORDER_SIZE, BORDER_SIZE);
        }

	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Add all tiles to the texture, then save it out
	    ///          </summary>
	    ///
        /// In:		<param name="_path">Folder we're loading from (and have to save to)</param>
	    ///
	    // #############################################################################################
        public static unsafe void BuildTileMap( string _path ) 
        {
            // Make a REALLY large texture!
            UInt32[] Texture = new UInt32[TWIDTH * THEIGHT * 4];

            // Now add all the tiles to it
            int tilenumber = 0;
            foreach(Tile t in Tiles)
            {
                int dest_index = ((tilenumber / TROW) * (TWIDTH*TILEHEIGHT)) + ((tilenumber % TROW) * TILEWIDTH) + BORDER_SIZE + (BORDER_SIZE*TWIDTH);
                AddTile(t, Texture, dest_index );
                tilenumber++;
            }



            // Now convert into a PNG and save it out
            Bitmap b;
            fixed (UInt32* pData = &Texture[0])
            {
                b = new Bitmap(TWIDTH, THEIGHT, TWIDTH*4, System.Drawing.Imaging.PixelFormat.Format32bppArgb, (IntPtr)((byte*)pData));
                Image img = (Image) b;

                // Save to the folder we're loadiong from
                img.Save(_path+"\\_TILES_.PNG", ImageFormat.Png);
            }
        }


	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Parse the provided folder and get all filenames, then load in all the tiles,
        ///          	and then sort them using the number at the start of the filename
	    ///          </summary>
	    ///
	    /// In:		<param name="_folder">Source folder holding all the .PNG tiles</param>
	    ///
	    // #############################################################################################
        public static string LoadTiles(string _folder)
        {
            try
            {
                // Get the list of files
                string[] list = Directory.GetFiles(_folder, "*.png");
                if( list.Length ==0 ) return "No PNG files found";

                // Load them all in, and parse the number at the start of the filename
                for (int i = 0; i < list.Length; i++){

                    // Make sure we're not adding the file we've saved before...
                    if (Path.GetFileName(list[i]) != "_TILES_.PNG")
                    {
                        Tiles.Add(new Tile(list[i]));
                    }
                }
            }
            catch (Exception ex)
            {
                return ex.Message;
            }


            // Sort them by tile number
            Tiles.Sort(
                  delegate(Tile p1, Tile p2)
                  {
                      if (p1.TileIndex == p2.TileIndex) return 0;
                      
                      if (p1.TileIndex >= p2.TileIndex)
                      {
                          return 1;
                      }
                      return -1;
                  }
                );
            return null;
        }



	    // #############################################################################################
	    /// Function:<summary>
	    ///          	
	    ///          </summary>
	    ///
	    /// In:		<param name="_png"></param>
	    /// Out:	<returns>
	    ///				
	    ///			</returns>
	    // #############################################################################################
        public static Map GenerateMap(string _png)
        {
            Tile tile = new Tile(_png );
            Map map =new Map(tile);
            map.Generate();
            string out_file = Path.GetDirectoryName(_png)+"\\"+Path.GetFileNameWithoutExtension(_png)+".city";
            map.Save(out_file);


            return map;
        }


	    // #############################################################################################
	    /// Function:<summary>
	    ///          	
	    ///          </summary>
	    ///
	    /// In:		<param name="args"></param>
	    ///
	    // #############################################################################################
        static void Main(string[] args)
        {
            if (args.Length == 0)
            {
                MessageBox.Show("Drag a folder onto the .EXE. The file _TILES_.PNG will be saved in that folder");
                return;
            }

            // If its a single image, then build a MAP using it!
            if( args[0].EndsWith(".png")){
                Map m = GenerateMap(args[0]);

            }else{
                string message = LoadTiles(args[0]);
                if(message!=null)
                {
                    MessageBox.Show("Error loading tiles\n"+message);
                    return;
                }
                BuildTileMap( args[0] );
            }
        }
    }
}
