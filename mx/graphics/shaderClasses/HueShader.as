package mx.graphics.shaderClasses
{
   import flash.display.Shader;


   public class HueShader extends Shader
   {
      public function HueShader() {
         super(new ShaderClass());
         return;
      }

      private static var ShaderClass:Class = HueShader_ShaderClass;
   }

}