package com.reinatech.shpainter
{
   import mx.core.MovieClipLoaderAsset;
   import flash.utils.ByteArray;


   public class Brushes_brush3Cl extends MovieClipLoaderAsset
   {
      public function Brushes_brush3Cl() {
         this.dataClass=Brushes_brush3Cl_dataClass;
         super();
         initialWidth=400 / 20;
         initialHeight=400 / 20;
         return;
      }

      private static var bytes:ByteArray = null;

      override public function get movieClipData() : ByteArray {
         if(bytes == null)
         {
            bytes=ByteArray(new this.dataClass());
         }
         return bytes;
      }

      public var dataClass:Class;
   }

}