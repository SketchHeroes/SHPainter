package mx.core
{

   use namespace mx_internal;

   public class EmbeddedFont extends Object
   {
      public function EmbeddedFont(param1:String, param2:Boolean, param3:Boolean) {
         super();
         this.initialize(param1,param2,param3);
         return;
      }

      mx_internal  static const VERSION:String = "4.5.0.20967";

      private var _bold:Boolean;

      public function get bold() : Boolean {
         return this._bold;
      }

      private var _fontName:String;

      public function get fontName() : String {
         return this._fontName;
      }

      private var _fontStyle:String;

      public function get fontStyle() : String {
         return this._fontStyle;
      }

      private var _italic:Boolean;

      public function get italic() : Boolean {
         return this._italic;
      }

      public function initialize(param1:String, param2:Boolean, param3:Boolean) : void {
         this._bold=param2;
         this._italic=param3;
         this._fontName=param1;
         this._fontStyle=EmbeddedFontRegistry.getInstance().getFontStyle(param2,param3);
         return;
      }
   }

}