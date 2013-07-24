package components
{
   import mx.core.MovieClipLoaderAsset;
   import flash.utils.ByteArray;


   public class BrushChooser__embed_mxml_brushes_brush50_swf_724696339 extends MovieClipLoaderAsset
   {
      public function BrushChooser__embed_mxml_brushes_brush50_swf_724696339() {
         this.dataClass=BrushChooser__embed_mxml_brushes_brush50_swf_724696339_dataClass;
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