package com.reinatech.shpainter
{
   import com.reinatech.shpainter.utils.GraphicUtils;


   public class DrawingSettings extends Object
   {
      public function DrawingSettings() {
         super();
         return;
      }

      private var _lineThickness:int = 1;

      private var _colorForeground:uint = 0;

      private var _opacity:Number = 1;

      public function setLineThickness(param1:int) : void {
         if(param1 > 0 && param1 <= 50)
         {
            this._lineThickness=param1;
         }
         return;
      }

      public function getLineThickness() : int {
         return this._lineThickness;
      }

      public function setForegroundColor(param1:uint) : void {
         this._colorForeground=param1;
         return;
      }

      public function getForegroundColor() : uint {
         return GraphicUtils.returnARGB(this._colorForeground,255);
      }

      public function setBackgroundColor(param1:String) : void {
         return;
      }

      public function getBackgroundColor() : String {
         return "";
      }

      public function setOpacity(param1:Number) : void {
         if(param1 >= 0 && param1 <= 1)
         {
            this._opacity=param1;
         }
         return;
      }

      public function getOpacity() : Number {
         return this._opacity;
      }

      public function setLinePixelHinting(param1:Boolean) : void {
         return;
      }

      public function getLinePixelHinting() : Boolean {
         return false;
      }

      public function setLineScaleMode(param1:String) : void {
         return;
      }

      public function getLineScaleMode() : String {
         return "normal";
      }

      public function setLineCaps(param1:String) : void {
         return;
      }

      public function getLineCaps() : String {
         return "";
      }

      public function setLineJoints(param1:String) : void {
         return;
      }

      public function getLineJoints() : String {
         return "";
      }

      public function setLineMiterLimit(param1:Number) : void {
         return;
      }

      public function getLineMiterLimit() : Number {
         return 3;
      }

      public function setLineSmoothness(param1:Boolean) : void {
         return;
      }

      public function getLineSmoothness() : Boolean {
         return true;
      }

      public function clone() : DrawingSettings {
         var _loc1_:DrawingSettings = new DrawingSettings();
         _loc1_.setForegroundColor(this.getForegroundColor());
         _loc1_.setLineThickness(this.getLineThickness());
         _loc1_.setOpacity(this.getOpacity());
         return _loc1_;
      }
   }

}