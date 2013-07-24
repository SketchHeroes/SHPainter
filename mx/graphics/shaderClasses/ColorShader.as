package mx.graphics.shaderClasses
{
   import flash.display.Shader;


   public class ColorShader extends Shader
   {
      public function ColorShader() {
         super(new ShaderClass());
         return;
      }

      private static var ShaderClass:Class = ColorShader_ShaderClass;
   }

}