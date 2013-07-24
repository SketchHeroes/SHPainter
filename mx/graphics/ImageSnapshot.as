package mx.graphics
{
   import mx.core.mx_internal;
   import flash.display.BitmapData;
   import flash.display.IBitmapDrawable;
   import flash.geom.Matrix;
   import flash.geom.ColorTransform;
   import flash.geom.Rectangle;
   import mx.core.IUIComponent;
   import flash.display.DisplayObject;
   import mx.core.IFlexDisplayObject;
   import mx.graphics.codec.IImageEncoder;
   import flash.utils.ByteArray;
   import flash.display.Bitmap;
   import flash.system.Capabilities;
   import mx.utils.Base64Encoder;
   import mx.core.UIComponent;
   import flash.display.Stage;
   import mx.graphics.codec.PNGEncoder;

   use namespace mx_internal;

   public dynamic class ImageSnapshot extends Object
   {
      public function ImageSnapshot(param1:int=0, param2:int=0, param3:ByteArray=null, param4:String=null) {
         this._properties={};
         super();
         this.contentType=param4;
         this.width=param1;
         this.height=param2;
         this.data=param3;
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      public static const MAX_BITMAP_DIMENSION:int = 2880;

      public static var defaultEncoder:Class = PNGEncoder;

      public static function captureBitmapData(param1:IBitmapDrawable, param2:Matrix=null, param3:ColorTransform=null, param4:String=null, param5:Rectangle=null, param6:Boolean=false) : BitmapData {
         var data:BitmapData = null;
         var width:int = 0;
         var height:int = 0;
         var normalState:Array = null;
         var scaledWidth:Number = NaN;
         var scaledHeight:Number = NaN;
         var reductionScale:Number = NaN;
         var source:IBitmapDrawable = param1;
         var matrix:Matrix = param2;
         var colorTransform:ColorTransform = param3;
         var blendMode:String = param4;
         var clipRect:Rectangle = param5;
         var smoothing:Boolean = param6;
         if(source  is  IUIComponent)
         {
            normalState=prepareToPrintObject(IUIComponent(source));
         }
         try
         {
            if(source != null)
            {
               if(source  is  DisplayObject)
               {
                  width=DisplayObject(source).width;
                  height=DisplayObject(source).height;
               }
               else
               {
                  if(source  is  BitmapData)
                  {
                     width=BitmapData(source).width;
                     height=BitmapData(source).height;
                  }
                  else
                  {
                     if(source  is  IFlexDisplayObject)
                     {
                        width=IFlexDisplayObject(source).width;
                        height=IFlexDisplayObject(source).height;
                     }
                  }
               }
            }
            if(!matrix)
            {
               matrix=new Matrix(1,0,0,1);
            }
            scaledWidth=width * matrix.a;
            scaledHeight=height * matrix.d;
            reductionScale=1;
            if(scaledWidth > MAX_BITMAP_DIMENSION)
            {
               reductionScale=scaledWidth / MAX_BITMAP_DIMENSION;
               scaledWidth=MAX_BITMAP_DIMENSION;
               scaledHeight=scaledHeight / reductionScale;
               matrix.a=scaledWidth / width;
               matrix.d=scaledHeight / height;
            }
            if(scaledHeight > MAX_BITMAP_DIMENSION)
            {
               reductionScale=scaledHeight / MAX_BITMAP_DIMENSION;
               scaledHeight=MAX_BITMAP_DIMENSION;
               scaledWidth=scaledWidth / reductionScale;
               matrix.a=scaledWidth / width;
               matrix.d=scaledHeight / height;
            }
            data=new BitmapData(scaledWidth,scaledHeight,true,0);
            data.draw(source,matrix,colorTransform,blendMode,clipRect,smoothing);
         }
         catch(e:Error)
         {
            data=null;
         }
         finally
         {
            if(source  is  IUIComponent)
            {
               finishPrintObject(IUIComponent(source),normalState);
            }
         }
         return data;
      }

      public static function captureImage(param1:IBitmapDrawable, param2:Number=0, param3:IImageEncoder=null, param4:Boolean=true) : ImageSnapshot {
         var snapshot:ImageSnapshot = null;
         var width:int = 0;
         var height:int = 0;
         var normalState:Array = null;
         var bytes:ByteArray = null;
         var data:BitmapData = null;
         var bitmap:Bitmap = null;
         var bounds:Rectangle = null;
         var source:IBitmapDrawable = param1;
         var dpi:Number = param2;
         var encoder:IImageEncoder = param3;
         var scaleLimited:Boolean = param4;
         var screenDPI:Number = Capabilities.screenDPI;
         if(dpi <= 0)
         {
            dpi=screenDPI;
         }
         var scale:Number = dpi / screenDPI;
         var matrix:Matrix = new Matrix(scale,0,0,scale);
         if(source  is  IUIComponent)
         {
            normalState=prepareToPrintObject(IUIComponent(source));
         }
         if(source != null)
         {
            if(source  is  DisplayObject)
            {
               width=DisplayObject(source).width;
               height=DisplayObject(source).height;
            }
            else
            {
               if(source  is  BitmapData)
               {
                  width=BitmapData(source).width;
                  height=BitmapData(source).height;
               }
               else
               {
                  if(source  is  IFlexDisplayObject)
                  {
                     width=IFlexDisplayObject(source).width;
                     height=IFlexDisplayObject(source).height;
                  }
               }
            }
         }
         if(!encoder)
         {
            encoder=new defaultEncoder();
         }
         width=width * matrix.a;
         height=height * matrix.d;
         if((scaleLimited) || width <= MAX_BITMAP_DIMENSION && height <= MAX_BITMAP_DIMENSION)
         {
            data=captureBitmapData(source,matrix);
            bitmap=new Bitmap(data);
            width=bitmap.width;
            height=bitmap.height;
            bytes=encoder.encode(data);
         }
         else
         {
            bounds=new Rectangle(0,0,width,height);
            bytes=captureAll(source,bounds,matrix);
            bytes=encoder.encodeByteArray(bytes,width,height);
         }
         snapshot=new ImageSnapshot(width,height,bytes,encoder.contentType);
         if(source  is  IUIComponent)
         {
            finishPrintObject(IUIComponent(source),normalState);
         }
         if(!-1)
         {
            throw _loc7_;
         }
         else
         {
            return snapshot;
         }
      }

      public static function encodeImageAsBase64(param1:ImageSnapshot) : String {
         var _loc2_:ByteArray = param1.data;
         var _loc3_:Base64Encoder = new Base64Encoder();
         _loc3_.encodeBytes(_loc2_);
         var _loc4_:String = _loc3_.drain();
         return _loc4_;
      }

      private static function captureAll(param1:IBitmapDrawable, param2:Rectangle, param3:Matrix, param4:ColorTransform=null, param5:String=null, param6:Rectangle=null, param7:Boolean=false) : ByteArray {
         var _loc10_:Rectangle = null;
         var _loc11_:Rectangle = null;
         var _loc12_:Rectangle = null;
         var _loc15_:ByteArray = null;
         var _loc16_:ByteArray = null;
         var _loc17_:ByteArray = null;
         var _loc8_:Matrix = param3.clone();
         var _loc9_:Rectangle = param2.clone();
         if(param2.width > MAX_BITMAP_DIMENSION)
         {
            _loc9_.width=MAX_BITMAP_DIMENSION;
            _loc10_=new Rectangle();
            _loc10_.x=_loc9_.width;
            _loc10_.y=param2.y;
            _loc10_.width=param2.width - _loc9_.width;
            _loc10_.height=param2.height;
         }
         if(param2.height > MAX_BITMAP_DIMENSION)
         {
            _loc9_.height=MAX_BITMAP_DIMENSION;
            _loc11_=new Rectangle();
            _loc11_.x=param2.x;
            _loc11_.y=_loc9_.height;
            _loc11_.width=_loc9_.width;
            _loc11_.height=param2.height - _loc9_.height;
            if(param2.width > MAX_BITMAP_DIMENSION)
            {
               _loc12_=new Rectangle();
               _loc12_.x=_loc9_.width;
               _loc12_.y=_loc9_.height;
               _loc12_.width=param2.width - _loc9_.width;
               _loc12_.height=param2.height - _loc9_.height;
            }
         }
         _loc8_.translate(-_loc9_.x,-_loc9_.y);
         _loc9_.x=0;
         _loc9_.y=0;
         var _loc13_:BitmapData = new BitmapData(_loc9_.width,_loc9_.height,true,0);
         _loc13_.draw(param1,_loc8_,param4,param5,param6,param7);
         var _loc14_:ByteArray = _loc13_.getPixels(_loc9_);
         _loc14_.position=0;
         _loc14_.position=0;
         return _loc14_;
      }

      private static function mergePixelRows(param1:ByteArray, param2:int, param3:ByteArray, param4:int, param5:int) : ByteArray {
         var _loc6_:ByteArray = new ByteArray();
         var _loc7_:int = param2 * 4;
         var _loc8_:int = param4 * 4;
         var _loc9_:* = 0;
         while(_loc9_ < param5)
         {
            _loc6_.writeBytes(param1,_loc9_ * _loc7_,_loc7_);
            _loc6_.writeBytes(param3,_loc9_ * _loc8_,_loc8_);
            _loc9_++;
         }
         _loc6_.position=0;
         return _loc6_;
      }

      private static function prepareToPrintObject(param1:IUIComponent) : Array {
         var _loc2_:Array = [];
         var _loc3_:DisplayObject = param1  is  DisplayObject?DisplayObject(param1):null;
         var _loc4_:Number = 0;
         return _loc2_;
      }

      private static function finishPrintObject(param1:IUIComponent, param2:Array) : void {
         var _loc3_:DisplayObject = param1  is  DisplayObject?DisplayObject(param1):null;
         var _loc4_:Number = 0;
         return;
      }

      private var _contentType:String;

      public function get contentType() : String {
         return this._contentType;
      }

      public function set contentType(param1:String) : void {
         this._contentType=param1;
         return;
      }

      private var _data:ByteArray;

      public function get data() : ByteArray {
         return this._data;
      }

      public function set data(param1:ByteArray) : void {
         this._data=param1;
         return;
      }

      private var _height:int;

      public function get height() : int {
         return this._height;
      }

      public function set height(param1:int) : void {
         this._height=param1;
         return;
      }

      private var _properties:Object;

      public function get properties() : Object {
         return this._properties;
      }

      public function set properties(param1:Object) : void {
         this._properties=param1;
         return;
      }

      private var _width:int;

      public function get width() : int {
         return this._width;
      }

      public function set width(param1:int) : void {
         this._width=param1;
         return;
      }
   }

}