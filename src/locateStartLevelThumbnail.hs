import Codec.Picture
import OpenCV.HighGui
import OpenCV.Juicy
import System.FilePath

workingDir = "/home/cmo/src/fps-bot/data"
thumbnail = workingDir </> "level-thumbnail.png"
startScreen = workingDir </> "screen-0169.png"

main = do
  w <- makeWindow "hello"
  a <- readImage thumbnail
  b <- readImage startScreen
  let (thum, start) =
          case (a, b) of
            (Right (ImageRGB8 thum'), Right (ImageRGB8 start')) -> 
               (fromImage thum', fromImage start') 
            _ -> error "something went wrong loading images"
  -- imshow w thum
  imshow w start
  waitKey 5000
