package components
{
   import mx.containers.Canvas;
   import mx.core.UIComponentDescriptor;
   import mx.core.IFlexModuleFactory;
   import mx.core.mx_internal;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import com.reinatech.shpainter.events.ColorChangedEvent;
   import flash.geom.Matrix;
   import flash.display.LineScaleMode;
   import flash.display.CapsStyle;
   import flash.display.GradientType;
   import flash.display.Graphics;
   import mx.events.FlexEvent;

   use namespace mx_internal;

   public class ColorSwatcher extends Canvas
   {
      public function ColorSwatcher() {
         this._documentDescriptor_=new UIComponentDescriptor(
            {
               "type":Canvas,
               "events":{"creationComplete":"___ColorSwatcher_Canvas1_creationComplete"}
            }
         );
         this.circleSprite=new Sprite();
         this.rectangleSprite=new Sprite();
         this.cursorSprite=new Sprite();
         this.rectangleCursor=new Sprite();
         this.colorCanvas=new Canvas();
         super();
         mx_internal::_document=this;
         this.addEventListener("creationComplete",this.___ColorSwatcher_Canvas1_creationComplete);
         return;
      }

      private var _documentDescriptor_:UIComponentDescriptor;

      private var __moduleFactoryInitialized:Boolean = false;

      override public function set moduleFactory(param1:IFlexModuleFactory) : void {
         super.moduleFactory=param1;
         if(this.__moduleFactoryInitialized)
         {
            return;
         }
         this.__moduleFactoryInitialized=true;
         return;
      }

      override public function initialize() : void {
         mx_internal::setDocumentDescriptor(this._documentDescriptor_);
         super.initialize();
         return;
      }

      private var _circleSwatchRadius:int = 35;

      private var _circleSwatchThickness:int = 7;

      private var isMouseDown:Boolean = false;

      private var color:uint = 0;

      private var circleBitmapData:BitmapData;

      private var rectangleBitmapData:BitmapData;

      private var circleSprite:Sprite;

      private var rectangleSprite:Sprite;

      private var cursorSprite:Sprite;

      private var rectangleCursor:Sprite;

      private var recBitmap:Bitmap;

      private var colorCanvas:Canvas;

      private function init() : void {
         this.circleBitmapData=this.drawCircleSwatch();
         var _loc1_:Bitmap = new Bitmap(this.circleBitmapData);
         this.circleSprite.addChild(_loc1_);
         this.circleSprite.addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDown);
         this.circleSprite.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMove);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onMouseUp);
         this.cursorSprite.graphics.lineStyle(1,0);
         this.cursorSprite.graphics.drawCircle(0,0,3);
         this.cursorSprite.x=13;
         this.cursorSprite.y=13;
         this.rectangleBitmapData=this.drawRectangleSwatch();
         this.recBitmap=new Bitmap(this.rectangleBitmapData);
         this.rectangleSprite.addChild(this.recBitmap);
         this.rectangleSprite.addEventListener(MouseEvent.MOUSE_DOWN,this.onRectMouseDown);
         this.rectangleSprite.addEventListener(MouseEvent.MOUSE_MOVE,this.onRectMouseMove);
         this.addEventListener(MouseEvent.MOUSE_UP,this.onRectMouseUp);
         this.rectangleCursor.graphics.lineStyle(1,0);
         this.rectangleCursor.graphics.drawCircle(0,0,3);
         this.rectangleCursor.graphics.lineStyle(1,16777215);
         this.rectangleCursor.graphics.drawCircle(0,0,4);
         this.rectangleCursor.x=25;
         this.rectangleCursor.y=25;
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(this.rectangleSprite);
         _loc2_.x=_loc2_.y=16;
         rawChildren.addChild(this.circleSprite);
         rawChildren.addChild(_loc2_);
         this.circleSprite.addChild(this.cursorSprite);
         this.rectangleSprite.addChild(this.rectangleCursor);
         this.colorCanvas.width=10;
         this.colorCanvas.height=this._circleSwatchRadius * 2;
         this.colorCanvas.setStyle("backgroundColor",0);
         this.colorCanvas.x=this._circleSwatchRadius * 2;
         this.colorCanvas.y=0;
         rawChildren.addChild(this.colorCanvas);
         return;
      }

      private function updateColorCanvas() : void {
         var _loc1_:uint = this.getRectangleColor();
         dispatchEvent(new ColorChangedEvent(ColorChangedEvent.CHANGE,true,false,_loc1_));
         this.colorCanvas.setStyle("backgroundColor",_loc1_);
         return;
      }

      private function getRectangleColor() : uint {
         return this.rectangleBitmapData.getPixel32(this.rectangleCursor.x,this.rectangleCursor.y);
      }

      private function onMouseMove(param1:MouseEvent) : void {
         if(this.isMouseDown)
         {
            this.color=this.circleBitmapData.getPixel(param1.localX,param1.localY);
            if(this.color != 0)
            {
               this.cursorSprite.x=param1.localX;
               this.cursorSprite.y=param1.localY;
               this.updateRectangle();
               this.updateColorCanvas();
            }
         }
         return;
      }

      private function onMouseDown(param1:MouseEvent) : void {
         this.isMouseDown=true;
         this.color=this.circleBitmapData.getPixel(param1.localX,param1.localY);
         if(this.color != 0)
         {
            this.cursorSprite.x=param1.localX;
            this.cursorSprite.y=param1.localY;
            this.updateRectangle();
            this.updateColorCanvas();
         }
         return;
      }

      private function onMouseUp(param1:MouseEvent) : void {
         this.isMouseDown=false;
         return;
      }

      private function onRectMouseMove(param1:MouseEvent) : void {
         if(this.isMouseDown)
         {
            if(param1.localX > 0 && param1.localY > 0 && param1.localX < this.recBitmap.width && param1.localY < this.recBitmap.height)
            {
               this.rectangleCursor.x=param1.localX;
               this.rectangleCursor.y=param1.localY;
               this.updateColorCanvas();
            }
         }
         return;
      }

      private function onRectMouseDown(param1:MouseEvent) : void {
         this.isMouseDown=true;
         if(param1.localX > 0 && param1.localY > 0 && param1.localX < this.recBitmap.width && param1.localY < this.recBitmap.height)
         {
            this.rectangleCursor.x=param1.localX;
            this.rectangleCursor.y=param1.localY;
            this.updateColorCanvas();
         }
         return;
      }

      private function onRectMouseUp(param1:MouseEvent) : void {
         this.isMouseDown=false;
         return;
      }

      private function drawCircleSwatch() : BitmapData {
         var _loc2_:* = NaN;
         var _loc3_:* = NaN;
         var _loc4_:* = NaN;
         var _loc5_:* = NaN;
         var _loc6_:* = NaN;
         var _loc7_:Matrix = null;
         var _loc8_:* = NaN;
         var _loc9_:* = NaN;
         var _loc10_:* = NaN;
         var _loc11_:* = NaN;
         var _loc12_:* = 0;
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.clear();
         _loc12_=1 + int(this._circleSwatchRadius / 50);
         var _loc13_:* = 0;
         while(_loc13_ < 360)
         {
            _loc2_=_loc13_ * Math.PI / 180;
            _loc3_=Math.cos(_loc2_) * 127 + 128 << 16;
            _loc4_=Math.cos(_loc2_ + 2 * Math.PI / 3) * 127 + 128 << 8;
            _loc5_=Math.cos(_loc2_ + 4 * Math.PI / 3) * 127 + 128;
            _loc6_=_loc3_ | _loc4_ | _loc5_;
            _loc10_=(this._circleSwatchRadius - this._circleSwatchThickness) * Math.cos(_loc2_);
            _loc11_=(this._circleSwatchRadius - this._circleSwatchThickness) * Math.sin(_loc2_);
            _loc8_=this._circleSwatchRadius * Math.cos(_loc2_);
            _loc9_=this._circleSwatchRadius * Math.sin(_loc2_);
            _loc7_=new Matrix();
            _loc7_.createGradientBox(this._circleSwatchRadius * 2,this._circleSwatchRadius * 2,_loc2_,-this._circleSwatchRadius,-this._circleSwatchRadius);
            _loc1_.graphics.lineStyle(_loc12_,0,1,false,LineScaleMode.NONE,CapsStyle.NONE);
            _loc1_.graphics.lineGradientStyle(GradientType.LINEAR,[16777215,_loc6_],[100,100],[127,255],_loc7_);
            _loc1_.graphics.moveTo(_loc10_,_loc11_);
            _loc1_.graphics.lineTo(_loc8_,_loc9_);
            _loc13_++;
         }
         _loc1_.x=_loc1_.y=this._circleSwatchRadius;
         var _loc14_:Sprite = new Sprite();
         _loc14_.addChild(_loc1_);
         var _loc15_:BitmapData = new BitmapData(_loc14_.width,_loc14_.height,true,0);
         _loc15_.draw(_loc14_);
         return _loc15_;
      }

      private function drawRectangleSwatch() : BitmapData {
         var _loc1_:String = GradientType.LINEAR;
         var _loc2_:Array = [16777215,this.color];
         var _loc3_:Array = [1,1];
         var _loc4_:Array = [0,255];
         var _loc5_:Matrix = new Matrix();
         var _loc6_:String = GradientType.LINEAR;
         var _loc7_:Array = [0,0];
         var _loc8_:Array = [0,1];
         var _loc9_:Array = [0,255];
         var _loc10_:Matrix = new Matrix();
         var _loc11_:* = 39;
         var _loc12_:* = 39;
         var _loc13_:Sprite = new Sprite();
         var _loc14_:BitmapData = new BitmapData(_loc11_,_loc12_,false,0);
         var _loc15_:Graphics = _loc13_.graphics;
         _loc13_.width=_loc11_;
         _loc13_.height=_loc12_;
         _loc13_.x=100;
         _loc13_.y=100;
         _loc5_.createGradientBox(_loc11_,_loc12_,0,0,0);
         _loc15_.clear();
         _loc15_.beginGradientFill(_loc1_,_loc2_,_loc3_,_loc4_,_loc5_);
         _loc15_.drawRect(0,0,_loc11_,_loc12_);
         _loc15_.endFill();
         _loc10_.createGradientBox(_loc11_,_loc12_,90 * Math.PI / 180,0,0);
         _loc15_.beginGradientFill(_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
         _loc15_.moveTo(0,0);
         _loc15_.lineTo(_loc11_,0);
         _loc15_.lineTo(_loc11_,_loc12_);
         _loc15_.lineTo(0,_loc12_);
         _loc15_.lineTo(0,0);
         _loc15_.endFill();
         _loc14_.draw(_loc13_);
         return _loc14_;
      }

      private function updateRectangle() : void {
         var _loc1_:String = GradientType.LINEAR;
         var _loc2_:Array = [16777215,0];
         var _loc3_:Array = [1,1];
         var _loc4_:Array = [0,255];
         var _loc5_:Matrix = new Matrix();
         var _loc6_:String = GradientType.LINEAR;
         var _loc7_:Array = [0,this.color];
         var _loc8_:Array = [0,1];
         var _loc9_:Array = [0,255];
         var _loc10_:Matrix = new Matrix();
         var _loc11_:* = 39;
         var _loc12_:* = 39;
         var _loc13_:Sprite = new Sprite();
         this.rectangleBitmapData.dispose();
         this.rectangleBitmapData=new BitmapData(_loc11_,_loc12_,false,0);
         var _loc14_:Graphics = _loc13_.graphics;
         _loc13_.width=_loc11_;
         _loc13_.height=_loc12_;
         _loc13_.x=100;
         _loc13_.y=100;
         _loc5_.createGradientBox(_loc11_,_loc12_,0,0,0);
         _loc14_.clear();
         _loc14_.beginGradientFill(_loc1_,_loc2_,_loc3_,_loc4_,_loc5_);
         _loc14_.drawRect(0,0,_loc11_,_loc12_);
         _loc14_.endFill();
         _loc10_.createGradientBox(_loc11_,_loc12_,90 * Math.PI / 180,0,0);
         _loc14_.beginGradientFill(_loc6_,_loc7_,_loc8_,_loc9_,_loc10_);
         _loc14_.moveTo(0,0);
         _loc14_.lineTo(_loc11_,0);
         _loc14_.lineTo(_loc11_,_loc12_);
         _loc14_.lineTo(0,_loc12_);
         _loc14_.lineTo(0,0);
         _loc14_.endFill();
         this.rectangleBitmapData.draw(_loc13_);
         this.recBitmap.bitmapData=this.rectangleBitmapData;
         return;
      }

      public function ___ColorSwatcher_Canvas1_creationComplete(param1:FlexEvent) : void {
         this.init();
         return;
      }
   }

}