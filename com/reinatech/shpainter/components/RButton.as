package com.reinatech.shpainter.components
{
   import mx.controls.Button;


   public class RButton extends Button
   {
      public function RButton() {
         super();
         return;
      }

      private var _toolClassName:String;

      public function set toolClassName(param1:String) : void {
         this._toolClassName=param1;
         return;
      }

      public function get toolClassName() : String {
         return this._toolClassName;
      }
   }

}