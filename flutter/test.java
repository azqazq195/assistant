<insert id="insertAction" useGeneratedKeys="true" keyProperty="value.id">
	insert into ${siteName}.action (
		<trim suffixOverrides=", ">
			<if test="value.id != -1">id,</if>
			<if test="value.sessionId != -1">session_id,</if>
			<if test="value.userId != -1">user_id,</if>
			<if test="value.category != null">ccategory,</if>
			<if test="value.type != null">ctype,</if>
			<if test="value.url != null">curl,</if>
			<if test="value.organization != null">corganization,</if>
			<if test="value.name != null">cname,</if>
			<if test="value.title != null">ctitle,</if>
			<if test="value.email != null">cemail,</if>
			<if test="value.phone != null">cphone,</if>
			<if test="value.siteName != null">csite_name,</if>
			<if test="value.requests != null">crequests,</if>
			<if test="value.responses != null">cresponses,</if>
			<if test="value.handled != -1">chandled,</if>
			<if test="value.dateHandled != null">cdate_handled,</if>
			<if test="value.taxFileId != -1">ctax_file_id,</if>
			<if test="value.advancedQty != -1">cadvanced_qty,</if>
			<if test="value.standardQty != -1">cstandard_qty,</if>
			<if test="value.webhardQty != -1">cwebhard_qty,</if>
			<if test="value.viewerQty != -1">cviewer_qty,</if>
			<if test="value.projectQty != -1">cproject_qty,</if>
			<if test="value.changeQty != -1">cchange_qty,</if>
			<if test="value.manufacturingQty != -1">cmanufacturing_qty,</if>
			<if test="value.qualityQty != -1">cquality_qty,</if>
			<if test="value.rmsQty != -1">crms_qty,</if>
			<if test="value.testQty != -1">ctest_qty,</if>
			<if test="value.contractType != null">ccontract_type,</if>
			<if test="value.privacyAgreed != -1">cprivacy_agreed,</if>
			<if test="value.prAgreed != -1">cpr_agreed,</if>
			<if test="value.product != null">cproduct,</if>
			<if test="value.benefit != null">cbenefit,</if>
			<if test="value.businessType != null">cbusiness_type,</if>
			<if test="value.date != null">cdate,</if>
		</trim>
	) values (
		<trim suffixOverrides=",">
			<if test="value.id != -1">#{value.id},</if>
			<if test="value.sessionId != -1">#{value.sessionId},</if>
			<if test="value.userId != -1">#{value.userId},</if>
			<if test="value.category != null">#{value.category},</if>
			<if test="value.type != null">#{value.type},</if>
			<if test="value.url != null">#{value.url},</if>
			<if test="value.organization != null">#{value.organization},</if>
			<if test="value.name != null">#{value.name},</if>
			<if test="value.title != null">#{value.title},</if>
			<if test="value.email != null">#{value.email},</if>
			<if test="value.phone != null">#{value.phone},</if>
			<if test="value.siteName != null">#{value.siteName},</if>
			<if test="value.requests != null">#{value.requests},</if>
			<if test="value.responses != null">#{value.responses},</if>
			<if test="value.handled != -1">#{value.handled},</if>
			<if test="value.dateHandled != null">#{value.dateHandled},</if>
			<if test="value.taxFileId != -1">#{value.taxFileId},</if>
			<if test="value.advancedQty != -1">#{value.advancedQty},</if>
			<if test="value.standardQty != -1">#{value.standardQty},</if>
			<if test="value.webhardQty != -1">#{value.webhardQty},</if>
			<if test="value.viewerQty != -1">#{value.viewerQty},</if>
			<if test="value.projectQty != -1">#{value.projectQty},</if>
			<if test="value.changeQty != -1">#{value.changeQty},</if>
			<if test="value.manufacturingQty != -1">#{value.manufacturingQty},</if>
			<if test="value.qualityQty != -1">#{value.qualityQty},</if>
			<if test="value.rmsQty != -1">#{value.rmsQty},</if>
			<if test="value.testQty != -1">#{value.testQty},</if>
			<if test="value.contractType != null">#{value.contractType},</if>
			<if test="value.privacyAgreed != -1">#{value.privacyAgreed},</if>
			<if test="value.prAgreed != -1">#{value.prAgreed},</if>
			<if test="value.product != null">#{value.product},</if>
			<if test="value.benefit != null">#{value.benefit},</if>
			<if test="value.businessType != null">#{value.businessType},</if>
			<if test="value.date != null">#{value.date},</if>
		</trim>
	)
</insert>