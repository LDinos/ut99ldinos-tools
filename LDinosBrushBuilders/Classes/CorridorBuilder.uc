//=============================================================================
// CorridorBuilder: Builds a curved corridor.
//=============================================================================
class CorridorBuilder extends BrushBuilder;

var() int InnerRadius, CorridorHeight, CorridorWidth, AngleOfCurve, NumDivisions;
var() name GroupName;
var() bool CounterClockwise;

function BuildCurvedStair( int Direction )
{
	local rotator RotStep;
	local vector vtx, NewVtx;
	local int x, z, InnerStart, OuterStart, BottomInnerStart, BottomOuterStart;

	RotStep.Yaw = (65536.0f * (AngleOfCurve / 360.0f)) / NumDivisions;

	if( CounterClockwise )
	{
		RotStep.Yaw *= -1;
		Direction *= -1;
	}

	// Generate the inner curve points.
	InnerStart = GetVertexCount();
	vtx.x = InnerRadius;
	for( x = 0 ; x < (NumDivisions + 1) ; x++ )
	{				
		NewVtx = vtx >> (RotStep * x);
		Vertex3f( NewVtx.x, NewVtx.y, vtx.z);
        vtx.z = CorridorHeight;
		Vertex3f( NewVtx.x, NewVtx.y, vtx.z );
	}

	// Generate the outer curve points.
	OuterStart = GetVertexCount();
	vtx.x = InnerRadius + CorridorWidth;
    vtx.z = 0;
	for( x = 0 ; x < (NumDivisions + 1) ; x++ )
	{				
		NewVtx = vtx >> (RotStep * x);

		Vertex3f( NewVtx.x, NewVtx.y, vtx.z );
        vtx.z = CorridorHeight;
		Vertex3f( NewVtx.x, NewVtx.y, vtx.z );
	}

	// Generate the bottom inner curve points.
	BottomInnerStart = GetVertexCount();
	vtx.x = InnerRadius;
    vtx.z = 0;
	for( x = 0 ; x < (NumDivisions + 1) ; x++ )
	{
		NewVtx = vtx >> (RotStep * x);
		Vertex3f( NewVtx.x, NewVtx.y, vtx.z);
	}

	// Generate the bottom outer curve points.
	BottomOuterStart = GetVertexCount();
	vtx.x = InnerRadius + CorridorWidth;
	for( x = 0 ; x < (NumDivisions + 1) ; x++ )
	{
		NewVtx = vtx >> (RotStep * x);
		Vertex3f( NewVtx.x, NewVtx.y, vtx.z);
	}

	for( x = 0 ; x < NumDivisions ; x++ )
	{
		Poly4i( Direction, InnerStart + (x * 2) + 2, InnerStart + (x * 2) + 1, OuterStart + (x * 2) + 1, OuterStart + (x * 2) + 2, 'steptop' );
		if (x==0) Poly4i( Direction, InnerStart + (x * 2) + 1, InnerStart + (x * 2), OuterStart + (x * 2), OuterStart + (x * 2) + 1, 'stepfront' );
		Poly4i( Direction, BottomInnerStart + x, InnerStart + (x * 2) + 1, InnerStart + (x * 2) + 2, BottomInnerStart + x + 1, 'innercurve' );
		Poly4i( Direction, OuterStart + (x * 2) + 1, BottomOuterStart + x, BottomOuterStart + x + 1, OuterStart + (x * 2) + 2, 'outercurve' );
		Poly4i( Direction, BottomInnerStart + x, BottomInnerStart + x + 1, BottomOuterStart + x + 1, BottomOuterStart + x, 'Bottom' );
	}

	// Back panel.
	Poly4i( Direction, BottomInnerStart + NumDivisions, InnerStart + (NumDivisions * 2), OuterStart + (NumDivisions * 2), BottomOuterStart + NumDivisions, 'back' );
}

function bool Build()
{
	local int i,j,k;

	if( AngleOfCurve<1 || AngleOfCurve>360 )
		return BadParameters("Angle is out of range.");
	if( InnerRadius<1 || CorridorWidth<1 || NumDivisions<1 )
		return BadParameters();

	BeginBrush( false, GroupName );
	BuildCurvedStair( 1 );
	return EndBrush();
}

defaultproperties {
    InnerRadius=256
    CorridorHeight=256
    CorridorWidth=256
    AngleOfCurve=90
    NumDivisions=4
    CounterClockwise=False
    GroupName=Corridor
    BitmapFilename="BBCorridor"
    ToolTip="Corridor"
}