//=============================================================================
// CylinderBuilder: Builds a 3D cylinder brush with different radius for each base.
//=============================================================================
class CapBuilder extends BrushBuilder;

var() float Height, BigRadius, SmallRadius;
var() int Sides;
var() name GroupName;
var() bool AlignToSide, Hollow;

function BuildCylinder( int Direction, bool AlignToSide, int Sides, float Height, float BigRadius, float SmallRadius )
{
	local int n,i,j,q,Ofs;
	n = GetVertexCount();
	if( AlignToSide )
	{
		BigRadius /= cos(pi/Sides);
        SmallRadius /= cos(pi/Sides);
		Ofs = 1;
	}

	// Vertices.
	for( i=0; i<Sides; i++ ) {
        j = -1;
        Vertex3f( BigRadius*sin((2*i+Ofs)*pi/Sides), BigRadius*cos((2*i+Ofs)*pi/Sides), j*Height/2 );
        j = 1;
        Vertex3f( SmallRadius*sin((2*i+Ofs)*pi/Sides), SmallRadius*cos((2*i+Ofs)*pi/Sides), j*Height/2 );
    }

	// Polys.
	for( i=0; i<Sides; i++ )
		Poly4i( Direction, n+i*2, n+i*2+1, n+((i*2+3)%(2*Sides)), n+((i*2+2)%(2*Sides)), 'Wall' );
}

function bool Build()
{
	local int i,j,k;

	if( Sides<3 )
		return BadParameters();
	if( Height<=0 || BigRadius<=0 || SmallRadius<=0 )
		return BadParameters();

	BeginBrush( false, GroupName );
	BuildCylinder( +1, AlignToSide, Sides, Height, BigRadius, SmallRadius );

    for( j=-1; j<2; j+=2 )
    {
        PolyBegin( j, 'Cap' );
        for( i=0; i<Sides; i++ )
            Polyi( i*2+(1-j)/2 );
        PolyEnd();
    }

	return EndBrush();
}

defaultproperties {
    Height=256.000000
    SmallRadius=128.000000
    BigRadius=256.000000
	Sides=8
    GroupName=Cap
    BitmapFilename="BBCap"
    ToolTip="Cap"
}

