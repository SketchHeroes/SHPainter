package com.reinatech.shpainter
{
   import flash.display.Sprite;


   public class Settings extends Object
   {
      public function Settings(param1:SingletonEnforcer) {
         super();
         if(!(param1  is  SingletonEnforcer))
         {
            throw new Error("Invalid Singleton access.");
         }
         else
         {
            return;
         }
      }

      private static var _instance:Settings;

      private static var _drawingSettings:DrawingSettings = new DrawingSettings();

      public static var CURRENT_BRUSH:Sprite;

      public static var CURRENT_BRUSH_NAME:String;

      public static var SCALE:int = 1;

      public static var UNDO_STEPS:int = 10;

      public static function getInstance() : Settings {
         if(_instance == null)
         {
            _instance=new Settings(new SingletonEnforcer());
         }
         return _instance;
      }

      public function getDrawingSettings() : DrawingSettings {
         return _drawingSettings;
      }
   }

}

   class SingletonEnforcer extends Object
   {
      function SingletonEnforcer() {
         super();
         return;
      }
   }
