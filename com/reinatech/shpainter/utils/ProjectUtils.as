package com.reinatech.shpainter.utils
{
   import flash.utils.ByteArray;
   import mx.utils.Base64Encoder;
   import mx.utils.Base64Decoder;
   import com.reinatech.player.Player;
   import com.reinatech.shpainter.history.HistoryStack;
   import com.reinatech.shpainter.tools.*;
   import flash.display.*;
   import flash.events.*;
   import com.reinatech.shpainter.DrawingSettings;
   import flash.net.FileFilter;
   import flash.net.FileReference;
   import com.reinatech.shpainter.SHPainterCanvas;


   public class ProjectUtils extends EventDispatcher
   {
      public function ProjectUtils() {
         super();
         return;
      }

      public static const PROJECT_LOADED:String = "projectLoaded";

      private static const DEFAULT_FILE_NAME:String = "paint.wps";

      private static const FILE_TYPES:Array = [new FileFilter("Painter Project","*.wps")];

      private static const SKETCH_FILE_TYPES:Array = [new FileFilter("Image","*.jpg")];

      public static function serializeToString(param1:Object) : String {
         if(param1 == null)
         {
            throw new Error("null isn\'t a legal serialization candidate");
         }
         else
         {
            _loc2_=new ByteArray();
            _loc2_.writeObject(param1);
            _loc2_.position=0;
            _loc3_=new Base64Encoder();
            _loc3_.encodeBytes(_loc2_);
            _loc4_=_loc3_.toString();
            return _loc4_;
         }
      }

      public static function readObjectFromStringBytes(param1:String) : Object {
         var _loc2_:Base64Decoder = new Base64Decoder();
         _loc2_.decode(param1);
         var _loc3_:ByteArray = _loc2_.toByteArray();
         _loc3_.position=0;
         return _loc3_.readObject();
      }

      public static function parseData(param1:String, param2:Player=null) : void {
         var _loc9_:Array = null;
         var _loc10_:Array = null;
         var _loc11_:* = 0;
         var _loc12_:String = null;
         var _loc13_:Array = null;
         var _loc14_:DrawingTool = null;
         var _loc3_:String = readObjectFromStringBytes(param1) as String;
         var param1:String = null;
         var _loc4_:Array = _loc3_.split(";");
         var _loc5_:int = _loc4_.length;
         var _loc6_:HistoryStack = HistoryStack.getInstance();
         var _loc7_:* = 0;
         if(param2 != null)
         {
            _loc7_=1;
            _loc9_=_loc4_[0].split(",");
            _loc10_=new Array();
            _loc11_=0;
            while(_loc11_ < _loc9_.length)
            {
               _loc10_[_loc11_]=int(_loc9_[_loc11_]);
               _loc11_++;
            }
            param2.setSteps(_loc10_);
         }
         var _loc8_:int = _loc7_;
         while(_loc8_ < _loc5_)
         {
            _loc12_=_loc4_[_loc8_];
            _loc13_=_loc12_.split("&");
            switch(_loc13_[0])
            {
               case "LineTool":
                  _loc14_=new LineTool(new DrawingSettings());
                  break;
               case "AirBrushTool":
                  _loc14_=new AirBrushTool(new DrawingSettings());
                  break;
               case "BrushTool":
                  _loc14_=new BrushTool(new DrawingSettings());
                  break;
               case "BucketTool":
                  _loc14_=new BucketTool(new DrawingSettings());
                  break;
               case "CircleTool":
                  _loc14_=new CircleTool(new DrawingSettings());
                  break;
               case "CurveTool":
                  _loc14_=new CurveTool(new DrawingSettings());
                  break;
               case "EraseTool":
                  _loc14_=new EraseTool(new DrawingSettings());
                  break;
               case "PenTool":
                  _loc14_=new PenTool(new DrawingSettings());
                  break;
               case "PolygonTool":
                  _loc14_=new PolygonTool(new DrawingSettings());
                  break;
               case "RectangleTool":
                  _loc14_=new RectangleTool(new DrawingSettings());
                  break;
               case "SmudgeTool":
                  _loc14_=new SmudgeTool(new DrawingSettings());
                  break;
            }
            if(!(_loc13_[0] == "") && !(_loc14_ == null))
            {
               _loc14_.loadToolData(_loc12_);
               _loc6_.putTool(_loc14_);
            }
            _loc8_++;
         }
         _loc6_.setIndex(0);
         return;
      }

      private var fr:FileReference;

      private var _isPlayer:Boolean;

      private var _tempState:String;

      public function exportProject() : void {
         var _loc6_:DrawingTool = null;
         var _loc1_:FileReference = new FileReference();
         _loc1_.addEventListener(Event.COMPLETE,this.onFileSave);
         _loc1_.addEventListener(Event.CANCEL,this.onCancel);
         _loc1_.addEventListener(IOErrorEvent.IO_ERROR,this.onSaveError);
         _loc1_.addEventListener(Event.SELECT,this.onFileSelected);
         _loc1_.addEventListener(Event.OPEN,this.onOpen);
         var _loc2_:HistoryStack = HistoryStack.getInstance();
         var _loc3_:Array = _loc2_.getStack();
         var _loc4_:* = "";
         var _loc5_:* = 0;
         while(_loc5_ < _loc2_.getLastIndex())
         {
            _loc6_=_loc3_[_loc5_] as DrawingTool;
            _loc4_=_loc4_ + (_loc6_.saveToolData() + ";");
            _loc5_++;
         }
         this._tempState=serializeToString(_loc4_);
         _loc1_.save(this._tempState,DEFAULT_FILE_NAME);
         return;
      }

      private function onOpen(param1:Event) : void {
         return;
      }

      private function onFileSelected(param1:Event) : void {
         var _loc2_:FileReference = param1.target as FileReference;
         var _loc3_:String = _loc2_.name;
         var _loc4_:int = _loc3_.length;
         var _loc5_:String = _loc3_.substr(_loc4_ - 4,_loc4_-1);
         if(_loc5_ != ".wps")
         {
            _loc2_.cancel();
            _loc2_=null;
            dispatchEvent(new Event(Event.CANCEL,true,false));
         }
         return;
      }

      public function importProject(param1:Boolean) : void {
         this._isPlayer=param1;
         this.fr=new FileReference();
         this.fr.addEventListener(Event.SELECT,this.onFileSelect);
         this.fr.addEventListener(Event.CANCEL,this.onCancel);
         this.fr.browse(FILE_TYPES);
         return;
      }

      public function importSketch() : void {
         this.fr=new FileReference();
         this.fr.addEventListener(Event.SELECT,this.onSketchSelect);
         this.fr.addEventListener(Event.CANCEL,this.onCancel);
         this.fr.browse(SKETCH_FILE_TYPES);
         return;
      }

      private function onSketchSelect(param1:Event) : void {
         this.fr.addEventListener(Event.COMPLETE,this.onSketchLoadComplete);
         this.fr.load();
         return;
      }

      private function onSketchLoadComplete(param1:Event) : void {
         var _loc2_:Loader = new Loader();
         _loc2_.contentLoaderInfo.addEventListener(Event.COMPLETE,this.onSketchLoaded);
         _loc2_.loadBytes(this.fr.data);
         return;
      }

      private function onSketchLoaded(param1:Event) : void {
         var _loc2_:LoaderInfo = param1.target as LoaderInfo;
         var _loc3_:Bitmap = _loc2_.content as Bitmap;
         SHPainterCanvas.getInstance().loadSketch(_loc3_);
         return;
      }

      private function onFileSelect(param1:Event) : void {
         this.fr.addEventListener(Event.COMPLETE,this.onLoadComplete);
         this.fr.addEventListener(IOErrorEvent.IO_ERROR,this.onLoadError);
         this.fr.load();
         return;
      }

      private function onCancel(param1:Event) : void {
         dispatchEvent(new Event(Event.CANCEL));
         this.fr=null;
         return;
      }

      private function onLoadComplete(param1:Event) : void {
         if(!this._isPlayer)
         {
            SHPainterCanvas.getInstance().clear();
         }
         var _loc2_:ByteArray = this.fr.data;
         var _loc3_:String = _loc2_.readUTFBytes(_loc2_.bytesAvailable);
         _loc2_=null;
         parseData(_loc3_);
         this.fr=null;
         dispatchEvent(new Event(ProjectUtils.PROJECT_LOADED));
         return;
      }

      private function onLoadError(param1:IOErrorEvent) : void {
         return;
      }

      private function onFileSave(param1:Event) : void {
         this.fr=null;
         return;
      }

      private function onSaveError(param1:IOErrorEvent) : void {
         this.fr=null;
         return;
      }
   }

}