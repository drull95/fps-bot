import Control.Concurrent
import System.Process
import System.FilePath
import System.Directory
    
workingDir = "/home/cmo/src/fps-bot/data"
screenFile = workingDir </> "screen.mpg"
nameTemplate = "screen-%04d.png"
             
data XDoTool
    = Key String

xdotool :: XDoTool -> IO ()
xdotool (Key s) = do
  system $ unwords ["xdotool key", s]
  return ()
                  
goDesktop :: Integer -> IO ()
goDesktop i =
    xdotool (Key $ concat ["Super_L+", show i])
            
xonotic :: IO ()
xonotic = do
  spawnCommand "xonotic-glx"
  return ()
         
recordDesktop :: FilePath -> IO ()
recordDesktop fp = do
  spawnCommand $ unwords ["ffmpeg -f x11grab -video_size 1280x1024 -framerate 15 -i $DISPLAY -c:v libx264", fp] 
  return ()
  
mkImages :: FilePath -> FilePath -> String -> IO ()
mkImages fp workingDir nameTemplate = do
    setCurrentDirectory workingDir
    spawnCommand $ unwords ["ffmpeg -i", fp, nameTemplate]
    return ()
                            
secs :: Int -> Int
secs = (* 1000000)
       
killall :: String -> IO ()
killall s = do
  system $ unwords ["killall", s]
  return ()
         
main = do
  goDesktop 5
  xonotic  
  removeFile screenFile
  recordDesktop screenFile
  threadDelay (secs 15)
  mkImages screenFile workingDir nameTemplate
  killall "ffmpeg"
