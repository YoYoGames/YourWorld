// **********************************************************************************************************************
// 
// Copyright (c)2013, YoYo Games Ltd. All Rights reserved.
// 
// File:			Tile.cs
// Created:			30/10/2013
// Author:			Mike
// Project:			TileBuilder
// Description:		Holds all the data for a single tile
// 
// Date				Version		BY		Comment
// ----------------------------------------------------------------------------------------------------------------------
// 30/10/2013		V1.0.0      MJD     1st version
// 
// **********************************************************************************************************************
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using System.Drawing;

namespace TileBuilder
{
    public class Tile
    {
        public string FullFilename;
        public string Filename;
        public int TileIndex;
        public UInt32[] TileData;
        public int Width;
        public int Height;

	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Return a pixel from the tile
	    ///          </summary>
	    ///
	    /// In:		<param name="_x">X Coordinate</param>
        ///			<param name="_y">X Coordinate</param>
	    /// Out:	<returns>
	    ///				The full 32bit pixel
	    ///			</returns>
	    // #############################################################################################
        public UInt32 GetPixel(int _x, int _y)
        {
            if( _x<0 || _x>=Width || _y<0 || _y>=Height) return 0;
            return TileData[_x + (_y * Width)];
        }
        // #############################################################################################
        /// Function:<summary>
        ///          	Return a pixel from the tile
        ///          </summary>
        ///
        /// In:		<param name="_x">X Coordinate</param>
        ///			<param name="_y">X Coordinate</param>
        /// Out:	<returns>
        ///				The full 32bit pixel
        ///			</returns>
        // #############################################################################################
        public void SetPixel(int _x, int _y, UInt32 _col)
        {
            if (_x < 0 || _x >= Width || _y < 0 || _y >= Height) return;
            TileData[_x + (_y * Width)] = _col;
        }

	    // #############################################################################################
	    /// Constructor: <summary>
	    ///              	Create a new tile holder
	    ///              </summary>
	    ///
	    /// In:		<param name="_filename">full path+filename to tile.png</param>
	    ///
	    // #############################################################################################
        public unsafe Tile( string _filename  )
        {
            // get the filename, and extract the number from the start
            FullFilename = _filename;
            Filename = Path.GetFileName(  _filename );
            TileIndex=0;
            for (int i = 0; i < Filename.Length; i++)
            {
                if (Filename[i] >= '0' && Filename[i] <= '9')
                {
                    TileIndex *= 10;
                    TileIndex += (int)Filename[i] - (int)'0';
                }else{
                    break;
                }
            }


            // Now load in the PNG and get the pixels from it....
            Bitmap pngImage = new Bitmap(FullFilename);
            TileData = new UInt32[pngImage.Width * pngImage.Height];
            Width = pngImage.Width;
            Height = pngImage.Height;

            // Now we want the raw pixels from it.
            var data = pngImage.LockBits(
                        new Rectangle(0, 0, pngImage.Width, pngImage.Height),
                        System.Drawing.Imaging.ImageLockMode.ReadWrite,
                        pngImage.PixelFormat);

            byte* pData = (byte*)data.Scan0;
            int index=0;
            for (int y = 0; y < pngImage.Height; y++)
            {
                for (int x = 0; x < pngImage.Width; x++)
                {
                    UInt32 col;
                    int ind = (y*data.Stride);
                    if( pngImage.PixelFormat== System.Drawing.Imaging.PixelFormat.Format24bppRgb )
                    {
                        // if 24bit (no alpha) then we only read 3 bytes, and force in 255 alpha
                        ind += x*3;
                        col = 0xff000000 | ((UInt32)pData[ind] + (UInt32)(pData[ind+1]<<8) + (UInt32)(pData[ind+2]<<16));
                    }else{
                        // If full ARGB, then copy the whole thing....
                        ind += x*4;
                        col = (UInt32)pData[ind] + (UInt32)(pData[ind+1]<<8) + (UInt32)(pData[ind+2]<<16) + (UInt32)(pData[ind+3]<<24);
                    }
                    TileData[index++] = col;
                }
            }
            pngImage.UnlockBits(data);
        }


	    // #############################################################################################
	    /// Function:<summary>
	    ///          	Show nicer debug info
	    ///          </summary>
	    // #############################################################################################
        public override string ToString()
        {
            return "i=" + TileIndex.ToString() + ",  w=" + Width.ToString() + ", h=" + Height.ToString();
        }
    }
}
