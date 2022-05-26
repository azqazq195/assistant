<insert id="insertAction" useGeneratedKeys="true" keyProperty="value.id">
	insert into ${siteName}.caction (
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
<select id="getAction" resultType="Action">
	select
		id as "id",
		session_id as "sessionId",
		user_id as "userId",
		ccategory as "category",
		ctype as "type",
		curl as "url",
		corganization as "organization",
		cname as "name",
		ctitle as "title",
		cemail as "email",
		cphone as "phone",
		csite_name as "siteName",
		crequests as "requests",
		cresponses as "responses",
		chandled as "handled",
		cdate_handled as "dateHandled",
		ctax_file_id as "taxFileId",
		cadvanced_qty as "advancedQty",
		cstandard_qty as "standardQty",
		cwebhard_qty as "webhardQty",
		cviewer_qty as "viewerQty",
		cproject_qty as "projectQty",
		cchange_qty as "changeQty",
		cmanufacturing_qty as "manufacturingQty",
		cquality_qty as "qualityQty",
		crms_qty as "rmsQty",
		ctest_qty as "testQty",
		ccontract_type as "contractType",
		cprivacy_agreed as "privacyAgreed",
		cpr_agreed as "prAgreed",
		cproduct as "product",
		cbenefit as "benefit",
		cbusiness_type as "businessType",
		cdate as "date"
	from
		${siteName}.caction
	<where>
		<if test="option.id != -1">and id = #{option.id}</if>
		<if test="option.sessionId != -1">and session_id = #{option.sessionId}</if>
		<if test="option.userId != -1">and user_id = #{option.userId}</if>
		<if test="option.category != null">and ccategory = #{option.category}</if>
		<if test="option.type != null">and ctype = #{option.type}</if>
		<if test="option.url != null">and curl = #{option.url}</if>
		<if test="option.organization != null">and corganization = #{option.organization}</if>
		<if test="option.name != null">and cname = #{option.name}</if>
		<if test="option.title != null">and ctitle = #{option.title}</if>
		<if test="option.email != null">and cemail = #{option.email}</if>
		<if test="option.phone != null">and cphone = #{option.phone}</if>
		<if test="option.siteName != null">and csite_name = #{option.siteName}</if>
		<if test="option.requests != null">and crequests = #{option.requests}</if>
		<if test="option.responses != null">and cresponses = #{option.responses}</if>
		<if test="option.handled != -1">and chandled = #{option.handled}</if>
		<if test="option.dateHandled != null">and cdate_handled = #{option.dateHandled}</if>
		<if test="option.taxFileId != -1">and ctax_file_id = #{option.taxFileId}</if>
		<if test="option.advancedQty != -1">and cadvanced_qty = #{option.advancedQty}</if>
		<if test="option.standardQty != -1">and cstandard_qty = #{option.standardQty}</if>
		<if test="option.webhardQty != -1">and cwebhard_qty = #{option.webhardQty}</if>
		<if test="option.viewerQty != -1">and cviewer_qty = #{option.viewerQty}</if>
		<if test="option.projectQty != -1">and cproject_qty = #{option.projectQty}</if>
		<if test="option.changeQty != -1">and cchange_qty = #{option.changeQty}</if>
		<if test="option.manufacturingQty != -1">and cmanufacturing_qty = #{option.manufacturingQty}</if>
		<if test="option.qualityQty != -1">and cquality_qty = #{option.qualityQty}</if>
		<if test="option.rmsQty != -1">and crms_qty = #{option.rmsQty}</if>
		<if test="option.testQty != -1">and ctest_qty = #{option.testQty}</if>
		<if test="option.contractType != null">and ccontract_type = #{option.contractType}</if>
		<if test="option.privacyAgreed != -1">and cprivacy_agreed = #{option.privacyAgreed}</if>
		<if test="option.prAgreed != -1">and cpr_agreed = #{option.prAgreed}</if>
		<if test="option.product != null">and cproduct = #{option.product}</if>
		<if test="option.benefit != null">and cbenefit = #{option.benefit}</if>
		<if test="option.businessType != null">and cbusiness_type = #{option.businessType}</if>
		<if test="option.date != null">and cdate = #{option.date}</if>
	</where>
</select>
<select id="getAction" resultType="Action">
	select
		id as "id",
		session_id as "sessionId",
		user_id as "userId",
		ccategory as "category",
		ctype as "type",
		curl as "url",
		corganization as "organization",
		cname as "name",
		ctitle as "title",
		cemail as "email",
		cphone as "phone",
		csite_name as "siteName",
		crequests as "requests",
		cresponses as "responses",
		chandled as "handled",
		cdate_handled as "dateHandled",
		ctax_file_id as "taxFileId",
		cadvanced_qty as "advancedQty",
		cstandard_qty as "standardQty",
		cwebhard_qty as "webhardQty",
		cviewer_qty as "viewerQty",
		cproject_qty as "projectQty",
		cchange_qty as "changeQty",
		cmanufacturing_qty as "manufacturingQty",
		cquality_qty as "qualityQty",
		crms_qty as "rmsQty",
		ctest_qty as "testQty",
		ccontract_type as "contractType",
		cprivacy_agreed as "privacyAgreed",
		cpr_agreed as "prAgreed",
		cproduct as "product",
		cbenefit as "benefit",
		cbusiness_type as "businessType",
		cdate as "date"
	from
		${siteName}.caction
	<where>
		<if test="option.id != -1">and id = #{option.id}</if>
		<if test="option.sessionId != -1">and session_id = #{option.sessionId}</if>
		<if test="option.userId != -1">and user_id = #{option.userId}</if>
		<if test="option.category != null">and ccategory = #{option.category}</if>
		<if test="option.type != null">and ctype = #{option.type}</if>
		<if test="option.url != null">and curl = #{option.url}</if>
		<if test="option.organization != null">and corganization = #{option.organization}</if>
		<if test="option.name != null">and cname = #{option.name}</if>
		<if test="option.title != null">and ctitle = #{option.title}</if>
		<if test="option.email != null">and cemail = #{option.email}</if>
		<if test="option.phone != null">and cphone = #{option.phone}</if>
		<if test="option.siteName != null">and csite_name = #{option.siteName}</if>
		<if test="option.requests != null">and crequests = #{option.requests}</if>
		<if test="option.responses != null">and cresponses = #{option.responses}</if>
		<if test="option.handled != -1">and chandled = #{option.handled}</if>
		<if test="option.dateHandled != null">and cdate_handled = #{option.dateHandled}</if>
		<if test="option.taxFileId != -1">and ctax_file_id = #{option.taxFileId}</if>
		<if test="option.advancedQty != -1">and cadvanced_qty = #{option.advancedQty}</if>
		<if test="option.standardQty != -1">and cstandard_qty = #{option.standardQty}</if>
		<if test="option.webhardQty != -1">and cwebhard_qty = #{option.webhardQty}</if>
		<if test="option.viewerQty != -1">and cviewer_qty = #{option.viewerQty}</if>
		<if test="option.projectQty != -1">and cproject_qty = #{option.projectQty}</if>
		<if test="option.changeQty != -1">and cchange_qty = #{option.changeQty}</if>
		<if test="option.manufacturingQty != -1">and cmanufacturing_qty = #{option.manufacturingQty}</if>
		<if test="option.qualityQty != -1">and cquality_qty = #{option.qualityQty}</if>
		<if test="option.rmsQty != -1">and crms_qty = #{option.rmsQty}</if>
		<if test="option.testQty != -1">and ctest_qty = #{option.testQty}</if>
		<if test="option.contractType != null">and ccontract_type = #{option.contractType}</if>
		<if test="option.privacyAgreed != -1">and cprivacy_agreed = #{option.privacyAgreed}</if>
		<if test="option.prAgreed != -1">and cpr_agreed = #{option.prAgreed}</if>
		<if test="option.product != null">and cproduct = #{option.product}</if>
		<if test="option.benefit != null">and cbenefit = #{option.benefit}</if>
		<if test="option.businessType != null">and cbusiness_type = #{option.businessType}</if>
		<if test="option.date != null">and cdate = #{option.date}</if>
	</where>
</select>
<update id="updateAction">
	update ${siteName}.caction
	<set>
		<if test="value.sessionId != -1">session_id = #{value.sessionId},</if>
		<if test="value.userId != -1">user_id = #{value.userId},</if>
		<if test="value.category != null">ccategory = #{value.category},</if>
		<if test="value.type != null">ctype = #{value.type},</if>
		<if test="value.url != null">curl = #{value.url},</if>
		<if test="value.organization != null">corganization = #{value.organization},</if>
		<if test="value.name != null">cname = #{value.name},</if>
		<if test="value.title != null">ctitle = #{value.title},</if>
		<if test="value.email != null">cemail = #{value.email},</if>
		<if test="value.phone != null">cphone = #{value.phone},</if>
		<if test="value.siteName != null">csite_name = #{value.siteName},</if>
		<if test="value.requests != null">crequests = #{value.requests},</if>
		<if test="value.responses != null">cresponses = #{value.responses},</if>
		<if test="value.handled != -1">chandled = #{value.handled},</if>
		<if test="value.dateHandled != null">cdate_handled = #{value.dateHandled},</if>
		<if test="value.taxFileId != -1">ctax_file_id = #{value.taxFileId},</if>
		<if test="value.advancedQty != -1">cadvanced_qty = #{value.advancedQty},</if>
		<if test="value.standardQty != -1">cstandard_qty = #{value.standardQty},</if>
		<if test="value.webhardQty != -1">cwebhard_qty = #{value.webhardQty},</if>
		<if test="value.viewerQty != -1">cviewer_qty = #{value.viewerQty},</if>
		<if test="value.projectQty != -1">cproject_qty = #{value.projectQty},</if>
		<if test="value.changeQty != -1">cchange_qty = #{value.changeQty},</if>
		<if test="value.manufacturingQty != -1">cmanufacturing_qty = #{value.manufacturingQty},</if>
		<if test="value.qualityQty != -1">cquality_qty = #{value.qualityQty},</if>
		<if test="value.rmsQty != -1">crms_qty = #{value.rmsQty},</if>
		<if test="value.testQty != -1">ctest_qty = #{value.testQty},</if>
		<if test="value.contractType != null">ccontract_type = #{value.contractType},</if>
		<if test="value.privacyAgreed != -1">cprivacy_agreed = #{value.privacyAgreed},</if>
		<if test="value.prAgreed != -1">cpr_agreed = #{value.prAgreed},</if>
		<if test="value.product != null">cproduct = #{value.product},</if>
		<if test="value.benefit != null">cbenefit = #{value.benefit},</if>
		<if test="value.businessType != null">cbusiness_type = #{value.businessType},</if>
		<if test="value.date != null">cdate = #{value.date},</if>
	</set>
	<where>
		<if test="value.id != -1">and id = #{value.id}</if>
		<if test="value.sessionId != -1">and session_id = #{value.sessionId}</if>
		<if test="value.userId != -1">and user_id = #{value.userId}</if>
		<if test="value.category != null">and ccategory = #{value.category}</if>
		<if test="value.type != null">and ctype = #{value.type}</if>
		<if test="value.url != null">and curl = #{value.url}</if>
		<if test="value.organization != null">and corganization = #{value.organization}</if>
		<if test="value.name != null">and cname = #{value.name}</if>
		<if test="value.title != null">and ctitle = #{value.title}</if>
		<if test="value.email != null">and cemail = #{value.email}</if>
		<if test="value.phone != null">and cphone = #{value.phone}</if>
		<if test="value.siteName != null">and csite_name = #{value.siteName}</if>
		<if test="value.requests != null">and crequests = #{value.requests}</if>
		<if test="value.responses != null">and cresponses = #{value.responses}</if>
		<if test="value.handled != -1">and chandled = #{value.handled}</if>
		<if test="value.dateHandled != null">and cdate_handled = #{value.dateHandled}</if>
		<if test="value.taxFileId != -1">and ctax_file_id = #{value.taxFileId}</if>
		<if test="value.advancedQty != -1">and cadvanced_qty = #{value.advancedQty}</if>
		<if test="value.standardQty != -1">and cstandard_qty = #{value.standardQty}</if>
		<if test="value.webhardQty != -1">and cwebhard_qty = #{value.webhardQty}</if>
		<if test="value.viewerQty != -1">and cviewer_qty = #{value.viewerQty}</if>
		<if test="value.projectQty != -1">and cproject_qty = #{value.projectQty}</if>
		<if test="value.changeQty != -1">and cchange_qty = #{value.changeQty}</if>
		<if test="value.manufacturingQty != -1">and cmanufacturing_qty = #{value.manufacturingQty}</if>
		<if test="value.qualityQty != -1">and cquality_qty = #{value.qualityQty}</if>
		<if test="value.rmsQty != -1">and crms_qty = #{value.rmsQty}</if>
		<if test="value.testQty != -1">and ctest_qty = #{value.testQty}</if>
		<if test="value.contractType != null">and ccontract_type = #{value.contractType}</if>
		<if test="value.privacyAgreed != -1">and cprivacy_agreed = #{value.privacyAgreed}</if>
		<if test="value.prAgreed != -1">and cpr_agreed = #{value.prAgreed}</if>
		<if test="value.product != null">and cproduct = #{value.product}</if>
		<if test="value.benefit != null">and cbenefit = #{value.benefit}</if>
		<if test="value.businessType != null">and cbusiness_type = #{value.businessType}</if>
		<if test="value.date != null">and cdate = #{value.date}</if>
	</where>
</update>