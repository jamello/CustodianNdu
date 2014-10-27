set ansi_nulls off;
go  
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID (N'[dbo].CiSp_GetProductsInfoForExtract', N'P') IS NOT NULL
begin
   DROP PROCEDURE [dbo].CiSp_GetProductsInfoForExtract;
   IF  EXISTS (	SELECT * FROM sys.objects 
				WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_GetProductsInfoForExtract]') 
				AND type in (N'P')
			  )
		Print '<<< Failed Dropping  Procedure [CiSp_GetProductsInfoForExtract] created !!! >>>'
	else
		Print '<<< Procedure [dbo].[CiSp_GetProductsInfoForExtract] Dropped >>>'
end   
else
	Print '<<< !!! Error Procedure [dbo].[CiSp_GetProductsInfoForExtract] does Not exist >>>' ;   
GO
create proc  [dbo].CiSp_GetProductsInfoForExtract
(		
		@pCompany_Id		nvarchar(3)
    ,   @pRefNo				nvarchar(50)
    ,   @pProductType		nvarchar(1)
    ,	@pProcessFromDate date  		
    ,	@pProcessEndDate  date  		
    ,   @rProductCd	        nvarchar(50) output
    ,   @rPolicyType	    nvarchar(5) output
    ,   @rAllocationCode	nvarchar(1) output
    ,   @rBusinessType	    nvarchar(25) output --new, renewal etc
    ,   @rTransAmt	        decimal(23,9) output    
    ,   @rMOPPrem	        decimal(23,9) output    
    ,   @rMOPContrib        decimal(23,9) output    
    ,   @rYear				int
   	,	@pDebug				tinyint 
	,	@rSqlError			int output
	,	@rErrorText			nvarchar(1000) output
 )
 with encryption
AS
	/*  
        Author	    : James C. Nnannah
        Create date : August 2014
        Description : Outputs some important info from various products to be used in Extract for Allocation
					  i.e. Claims, Premium, Co-Ins. and Fac 
		Version     : 1
		
	:-------:-----------History-----:---------------------------------------------------------------------------: 
	:  Ver  :Date      :Name        :Notes                                                                      :
	:-------:-----------------------:---------------------------------------------------------------------------: 
	:       :		   :            :																			:
	:       :          :            :												                            :
	:       :          :            :                                                                           :	    	    
	:       :          :            :															                :	    	    
	:       :          :            :                                                                           :	    	    
	:       :          :            :                                                                           :	    	    
	:-------:-----------------------:---------------------------------------------------------------------------: 
	
			
	*/
	    set nocount on;

		Declare @sPrintDebug	varchar(120)
		,		@ReturnCode		int
		,		@Rowcount		int 
		,		@PolicyStartDate			datetime 
		,		@ClaimDate			datetime 

			if @pDebug > 0 
				Print 'Starting CiSp_GetProductsInfoForExtract......... - ' 
				
			--
			--  initialiase the return variables
			--
				
			select  
					@Rowcount       = 0
				,   @rProductCd	    = ''
				,   @rPolicyType	= ''
				,   @rBusinessType	= ''
				,   @rTransAmt	    = 0 
				,   @rMOPPrem	    = 0
				,   @rMOPContrib    = 0
				,   @rYear			= ''

				,   @rErrorText     = ''
				,   @pDebug         = ISNULL(@pDebug,0)
 			--
			--
		    if (@pRefNo is null) 
		    begin
			    select @rErrorText = 'CiSp_GetProductsInfoForExtract....: Invalid Reference no. --> (' + isnull(@pRefNo,'Null') + ')'
				
			    if @pDebug > 0
				    print @rErrorText

			     return -236602
		    end				

		    if (@pProductType is null) 
		    begin
			    select @rErrorText = 'CiSp_GetProductsInfoForExtract....: Product Type --> (' + isnull(@pProductType,'Null') + ')'
				
			    if @pDebug > 0
				    print @rErrorText

			     return -236602
		    end				
		    
			--
			-- Check for and retrieve the various product details
			--
			--1. Claims
			if @pProductType = 'Y' --Receipt Type
			begin
			
				if @pDebug > 0
				   print '******** Start Claims Data Extract in CiSp_GetProductsInfoForExtract ..............'  

				SELECT 
					   @rProductCd = [TBIL_CLM_RPTD_PRDCT_CD]
					  ,@rPolicyType = 'Y'
					  , @PolicyStartDate = [TBIL_CLM_RPTD_POLY_FROM_DT]
					  ,@rTransAmt = [TBIL_CLM_RPTD_BASIC_LOSS_AMT_LC]
				FROM [TBIL_CLAIM_REPTED] WHERE [TBIL_CLM_RPTD_CLM_NO] = @pRefNo		
							
				if (@PolicyStartDate = getdate())
					Select	@rBusinessType ='New'
				else
					Select	@rBusinessType ='Renewal'
									
					select @rSqlError =  @@ERROR, @RowCount = @@ROWCOUNT

					if (@rSqlError != 0 ) or (@RowCount != 1)
					begin
						select @rErrorText = 'CiSp_GetProductsInfoForExtract....:Error retriving Claims details for ref no  --> (' + isnull(@pRefNo,'Null') + ')'
						
						if @pDebug > 0
							print @rErrorText

						 return -236605
					end				
							
			 end -- end of claims extract operation
			else if (@pProductType = 'D')or(@pProductType = 'P')or(@pProductType = 'U')or(@pProductType = 'F') or(@pProductType = 'C') 			
			begin
				if @pDebug > 0
				   print '******** Start Other Products Data Extract in CiSp_GetProductsInfoForExtract ..............'  

				if (@pProductType = 'D')
				begin
				    --Read the Premium info table
					SELECT 
						   @rProductCd = [TBIL_POL_PRM_PRDCT_CD]
						  ,@rPolicyType = 'P'
						  , @PolicyStartDate = [TBIL_POL_PRM_FROM]
						  ,@rAllocationCode = [TBIL_POL_PRM_ALLOC_CD]
					FROM TBIL_POLICY_PREM_INFO WHERE [TBIL_POL_PRM_PROP_NO] = @pRefNo		
					
					--Read the Premium details table i.e. get the MOP stuff
					SELECT 
						  @rMOPContrib = TBIL_POL_PRM_DTL_MOP_CONTRB_LC
						 ,@rMOPPrem = TBIL_POL_PRM_DTL_MOP_PRM_LC
					FROM TBIL_POLICY_PREM_DETAILS WHERE [TBIL_POL_PRM_DTL_PROP_NO] = @pRefNo		
					
				end
				else --others
				begin
				    --Read the Premium info table
					SELECT 
						   @rProductCd = [TBIL_POL_PRM_PRDCT_CD]
						  ,@rPolicyType = 'P'
						  , @PolicyStartDate = [TBIL_POL_PRM_FROM]
						  ,@rAllocationCode = [TBIL_POL_PRM_ALLOC_CD]
					FROM TBIL_POLICY_PREM_INFO WHERE [TBIL_POL_PRM_POLY_NO] = @pRefNo		

					--Read the Premium details table i.e. get the MOP stuff
					SELECT 
						  @rMOPContrib = TBIL_POL_PRM_DTL_MOP_CONTRB_LC
						 ,@rMOPPrem = TBIL_POL_PRM_DTL_MOP_PRM_LC
					FROM TBIL_POLICY_PREM_DETAILS WHERE [TBIL_POL_PRM_DTL_PROP_NO] = @pRefNo		
				
				end			
				if (@PolicyStartDate = getdate())
					Select	@rBusinessType ='New'
				else
					Select	@rBusinessType ='Renewal'

				SELECT @rYear = DATEDIFF(yyyy,@PolicyStartDate,GETDATE()) 
									
				--check for errors in the DB					
					select @rSqlError =  @@ERROR, @RowCount = @@ROWCOUNT

					if (@rSqlError != 0 ) or (@RowCount != 1)
					begin
						select @rErrorText = 'CiSp_GetProductsInfoForExtract....:Error retriving other product details for ref no  --> (' + isnull(@pRefNo,'Null') + ')'
						
						if @pDebug > 0
							print @rErrorText

						 return -236605
					end				


			end -- End of Other Products extract operation

return 0
GO

IF  EXISTS (SELECT * FROM sys.objects 
			WHERE object_id = OBJECT_ID(N'[dbo].[CiSp_GetProductsInfoForExtract]') 
			AND type in (N'P'))
	Print '<<< Success Procedure [dbo].[CiSp_GetProductsInfoForExtract] created !!! >>>'
else
	Print '<<< !!! Error Procedure [dbo].[CiSp_GetProductsInfoForExtract] Not created >>>'
GO		  