class PyramidBuilder extends BrushBuilder;

//=============================================================================
// CubeBuilder: Builds a 3D cube brush.
//=============================================================================

var() float Height, Width, Breadth;
var() float WallThickness;
var() name GroupName;
var() bool Hollow;

function BuildCube( int Direction, float dx, float dy, float dz)
{
    local int n,i,j,k;
    n = GetVertexCount();
    Vertex3f( -1*dx/2, -1*dy/2, -1*dz/2 );
    Vertex3f( -1*dx/2, 1*dy/2, -1*dz/2 );
    Vertex3f( 1*dx/2, -1*dy/2, -1*dz/2 );
    Vertex3f( 1*dx/2, 1*dy/2, -1*dz/2 );
    Vertex3f( 0, 0, 1*dz/2 );

    Poly3i(Direction,n+2,n+4,n+0);
    Poly3i(Direction,n+0,n+4,n+1);
    Poly3i(Direction,n+1,n+4,n+3);
    Poly3i(Direction,n+3,n+4,n+2);
    Poly4i(Direction,n+0,n+1,n+3,n+2);


}

event bool Build()
{
    if( Height<=0 || Width<=0 || Breadth<=0 )
        return BadParameters();
    if( Hollow && (Height<=WallThickness || Width<=WallThickness || Breadth<=WallThickness) )
        return BadParameters();

    BeginBrush( false, GroupName );
    BuildCube( +1, Breadth, Width, Height);
    if( Hollow )
        BuildCube( -1, Breadth-WallThickness, Width-WallThickness, Height-WallThickness);
    return EndBrush();
}

defaultproperties
{
      Height=256.000000
      Width=256.000000
      Breadth=256.000000
      WallThickness=16.000000
      GroupName="Pyranimd"
      Hollow=False
      BitmapFilename="BBPyramid"
      ToolTip="Pyramid"
}
