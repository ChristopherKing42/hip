{-# LANGUAGE FlexibleContexts, FlexibleInstances, MultiParamTypeClasses, TypeFamilies #-}
module Graphics.Image.External.Base (
  fromWord8, toWord8, fromWord16, toWord16,
  ImageFormat(..), Readable(..), Writable(..),
  ) where

import Data.Word (Word8, Word16)
import qualified Data.ByteString as B (ByteString)
import qualified Data.ByteString.Lazy as BL (ByteString)
import Graphics.Image.Interface

import Graphics.Image.ColorSpace

import Data.Bits


fromWord8 :: Word8 -> Double
fromWord8 w = fromIntegral w / (fromIntegral (maxBound :: Word8))
toWord8 :: Double -> Word8
toWord8 w = round (fromIntegral (maxBound :: Word8) * w)

fromWord16 :: Word16 -> Double
fromWord16 w = fromIntegral w / (fromIntegral (maxBound :: Word16))
toWord16 :: Double -> Word16
toWord16 w = round (fromIntegral (maxBound :: Word16) * w)



class ImageFormat format where
  data SaveOption format

  ext :: format -> String

  exts :: format -> [String]
  exts f = [ext f]

  isFormat :: String -> format -> Bool
  isFormat e f = e `elem` (exts f)

-- needed: extension, format, colorspace
class ImageFormat format => Writable img format where

  encode :: format -> [SaveOption format] -> img -> BL.ByteString


class ImageFormat format => Readable img format where

  decode :: format -> B.ByteString -> Either String img



scaleBits = 16

fix :: Float -> Int
fix x = floor $ x * fromIntegral ((1 :: Int) `unsafeShiftL` scaleBits) + 0.5
  
  

{-
-- | Format types that an image can be read in.
data InputFormat =
  BMPin   -- ^ Bitmap image with .bmp extension.
  | GIFin -- ^ Graphics Interchange Format image with .gif extension.
  | HDRin -- ^ High-dynamic-range image with .hdr extension.
  | JPGin -- ^ Joint Photographic Experts Group image with .jpg or .jpeg
          -- extension. Output quality factor can be specified from 0 to a 100
  | PNGin -- ^ Portable Network Graphics image with .png extension
  | TGAin -- ^ Truevision Graphics Adapter image with .tga extension.
  | TIFin -- ^ Tagged Image File Format image with .tif or .tiff extension
  | PBMin -- ^ Netpbm portable bitmap image with .pbm extension.
  | PGMin -- ^ Netpbm portable graymap image with .pgm extension.
  | PPMin -- ^ Netpbm portable pixmap image with .ppm extension.


instance Show InputFormat where
  show BMPin = "Bitmap"
  show GIFin = "Gif"
  show HDRin = "HDR"
  show JPGin = "Jpeg"
  show PNGin = "PNG"
  show TGAin = "TGA"
  show TIFin = "Tiff"
  show PBMin = "PBM"
  show PGMin = "PGM"
  show PPMin = "PPM"
  

-- | Format types that an image can be saved in.
data OutputFormat =
  BMP               -- ^ Bitmap image with @.bmp@ extension.
  
  -- \ | GIF             -- ^ Graphics Interchange Format image with @.gif@ extension.
  | HDR             -- ^ High-dynamic-range image with @.hdr@ extension.
  | JPG Word8       -- ^ Joint Photographic Experts Group image with @.jpg@ or
                    -- @.jpeg@ extension. Output quality factor can be specified
                    -- from 0 to a 100.
  | PNG             -- ^ Portable Network Graphics image with @.png@ extension.
    
  -- \ | TGA             -- ^ Truevision Graphics Adapter image with .tga extension.
  | TIF             -- ^ Tagged Image File Format image with @.tif@ or @.tiff@
                    -- extension.

    
instance Show OutputFormat where
  show BMP     = "Bitmap"
  --show GIF     = "Gif"
  show HDR     = "HDR"
  show (JPG _) = "Jpeg"
  show PNG     = "PNG"
  --show TGA     = "TGA"
  show TIF     = "Tiff"
  --show (PBM _) = "PBM"
  --show (PGM _) = "PGM"
  --show (PPM _) = "PPM"
-}
