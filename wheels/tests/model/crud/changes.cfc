<cfcomponent extends="wheelsMapping.test">

	<cfinclude template="/wheelsMapping/global/functions.cfm">

	<cffunction name="test_properties_and_setProperties">
		<cfset loc.author = model("author").findOne()>
		<cfset loc.author.setProperties(firstName="a", lastName="b")>
		<cfset loc.result = loc.author.properties()>
		<cfset loc.compareWith.id = loc.author.key()>
		<cfset loc.compareWith.firstName = "a">
		<cfset loc.compareWith.lastName = "b">
		<cfset assert("loc.result.toString() IS loc.compareWith.toString()")>
	</cffunction>

	<cffunction name="test_allChanges">
		<cfset loc.author = model("author").findOne()>
		<cfset loc.author.firstName = "a">
		<cfset loc.author.lastName = "b">
		<cfset loc.compareWith.firstName.changedFrom = "Per">
		<cfset loc.compareWith.firstName.changedTo = "a">
		<cfset loc.compareWith.lastName.changedFrom = "Djurner">
		<cfset loc.compareWith.lastName.changedTo = "b">
		<cfset loc.result = loc.author.allChanges()>
		<cfset assert("loc.result.toString() IS loc.compareWith.toString()")>
	</cffunction>

	<cffunction name="test_changedProperties">
		<cfset loc.author = model("author").findOne()>
		<cfset loc.author.firstName = "a">
		<cfset loc.author.lastName = "b">
		<cfset loc.result = loc.author.changedProperties()>
		<cfset assert("loc.result IS 'firstName,lastName'")>
	</cffunction>

	<cffunction name="test_changedProperties_without_changes">
		<cfset loc.author = model("author").findOne()>
		<cfset loc.result = loc.author.changedProperties()>
		<cfset assert("loc.result IS ''")>
	</cffunction>

	<cffunction name="test_changedProperties_change_and_back">
		<cfset loc.author = model("author").findOne()>
		<cfset loc.author.oldFirstName = loc.author.firstName>
		<cfset loc.author.firstName = "a">
		<cfset loc.result = loc.author.changedProperties()>
		<cfset assert("loc.result IS 'firstName'")>
		<cfset loc.author.firstName = loc.author.oldFirstName>
		<cfset loc.result = loc.author.changedProperties()>
		<cfset assert("loc.result IS ''")>
	</cffunction>

	<cffunction name="test_key">
		<cfset loc.author = model("author").findOne()>
		<cfset loc.result = loc.author.key()>
		<cfset assert("loc.result IS loc.author.id")>
	</cffunction>

	<cffunction name="test_key_with_new">
		<cfset loc.author = model("author").new(id=1, firstName="Per", lastName="Djurner")>
		<cfset loc.result = loc.author.key()>
		<cfset assert("loc.result IS 1")>
	</cffunction>

	<cffunction name="test_isNew">
		<cfset loc.author = model("author").new(firstName="Per", lastName="Djurner")>
		<cfset loc.result = loc.author.isNew()>
		<cfset assert("loc.result IS true")>
		<cfset loc.author.save()>
		<cfset loc.result = loc.author.isNew()>
		<cfset assert("loc.result IS false")>
		<cfset loc.author.delete()>
	</cffunction>

	<cffunction name="test_isNew_with_find">
		<cfset loc.author = model("author").findOne()>
		<cfset loc.result = loc.author.isNew()>
		<cfset assert("loc.result IS false")>
	</cffunction>

	<cffunction name="test_hasChanged">
		<cfset loc.author = model("author").findOne(where="lastName = 'Djurner'")>
		<cfset loc.result = loc.author.hasChanged()>
		<cfset assert("loc.result IS false")>
		<cfset loc.author.lastName = "Petruzzi">
		<cfset loc.result = loc.author.hasChanged()>
		<cfset assert("loc.result IS true")>
		<cfset loc.author.lastName = "Djurner">
		<cfset loc.result = loc.author.hasChanged()>
		<cfset assert("loc.result IS false")>
	</cffunction>

	<cffunction name="test_hasChanged_with_new">
		<cfset loc.author = model("author").new(firstName="Per", lastName="Djurner")>
		<cfset loc.result = loc.author.hasChanged()>
		<cfset assert("loc.result IS true")>
		<cfset loc.author.save()>
		<cfset loc.result = loc.author.hasChanged()>
		<cfset assert("loc.result IS false")>
		<cfset loc.author.lastName = "Petruzzi">
		<cfset loc.result = loc.author.hasChanged()>
		<cfset assert("loc.result IS true")>
		<cfset loc.author.save()>
		<cfset loc.result = loc.author.hasChanged()>
		<cfset assert("loc.result IS false")>
		<cfset loc.author.delete()>
	</cffunction>

	<cffunction name="test_XXXHasChanged">
		<cfset loc.author = model("author").findOne(where="lastName = 'Djurner'")>
		<cfset loc.author.lastName = "Petruzzi">
		<cfset loc.result = loc.author.lastNameHasChanged()>
		<cfset assert("loc.result IS true")>
		<cfset loc.result = loc.author.firstNameHasChanged()>
		<cfset assert("loc.result IS false")>
	</cffunction>

	<cffunction name="test_changedFrom">
		<cfset loc.author = model("author").findOne(where="lastName = 'Djurner'")>
		<cfset loc.author.lastName = "Petruzzi">
		<cfset loc.result = loc.author.changedFrom(property="lastName")>
		<cfset assert("loc.result IS 'Djurner'")>
	</cffunction>
 
	<cffunction name="test_XXXChangedFrom">
		<cfset loc.author = model("author").findOne(where="lastName = 'Djurner'")>
		<cfset loc.author.lastName = "Petruzzi">
		<cfset loc.result = loc.author.lastNameChangedFrom(property="lastName")>
		<cfset assert("loc.result IS 'Djurner'")>
	</cffunction>

</cfcomponent>