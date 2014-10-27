set ansi_nulls off;
go  
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID (N'[dbo].CiSp_Validations', N'P') IS NOT NULL
begin
   DROP PROCEDURE [dbo].CiSp_Validations;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_Validations]') 
				AND type in (N'P')
			  )
		Print '<<< Failed Dropping  Procedure [CiSp_Validations] created !!! >>>'
	else
		Print '<<< Procedure [dbo].[CiSp_Validations] Dropped >>>'
end   
else
	Print '<<< !!! Error Procedure [dbo].[CiSp_Validations] does Not exist >>>' ;   
GO
create proc  [dbo].CiSp_Validations
(		
		@pCompany_Id		smallint
    ,	@pTransType			nvarchar(25)
    ,	@pTransId			nvarchar(25)
   	,	@pDebug				tinyint 
	,	@rSqlError			int output
	,	@rErrorText			nvarchar(1000) output
 )
 with encryption
AS
	/*  
        Author	    : Nnannah C. James
        Create date : Oct  2014
        Description : An Overloaded Method for Data Validatioin
		Version     : 1
		
	:-------:-----------History-----:---------------------------------------------------------------------------: 
	:  Ver  :Date      :Name        :Notes                                                                      :
	:-------:-----------------------:---------------------------------------------------------------------------: 
	:   2   :		   :J.Nnannah   :																			:
	:       :          :            :																			:
	:       :          :            :                                                                           :	    	    
	:   3   :		   :J. Nnannah  :																			:	    	    
	:       :          :            :                                                                           :	    	    
	:       :          :            :                                                                           :	    	    
	:-------:-----------------------:---------------------------------------------------------------------------: 
	
			
	*/
	    set nocount on;

		Declare @sPrintDebug	varchar(120)
		,		@ReturnCode		int
		,		@Rowcount		int 
		,		@Action			nvarchar(20)   /* Increase , Decrease */
		,		@Gross_Fees		decimal(21,6)
		,		@Fee_Tax		decimal(21,6)
		,		@Calc_Id		int
		,		@Available_Funds		decimal(21,6)
		,		@Units_Available		bigint
		,		@Pending_Cross_Deals	bigint
		,		@pUnits_On_Lien			bigint
		,		@pPending_Sell_Order	bigint

			if @pDebug > 0 
				Print 'Starting CiSp_Validations......... - ' 
				
			--
			--  initialiase variables
			--
				
			select  @rGross_Total    = 0 
				,	@rTotal_Fees     = 0
				,	@rNet_order      = 0
				,	@Rowcount       = 0
				,   @rErrorText     = ''
				,   @pAll_None       = ISNULL(@pAll_None,0)
				,   @pDebug         = ISNULL(@pDebug,0)
 			--
			-- validate value of @pMandate   
			--

			
return 0
GO

IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_Validations]') 
			AND type in (N'P'))
	Print '<<< Success Procedure [dbo].[CiSp_Validations] created !!! >>>'
else
	Print '<<< !!! Error Procedure [dbo].[CiSp_Validations] Not created >>>'
GO		  