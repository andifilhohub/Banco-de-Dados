CREATE OR REPLACE FUNCTION person.insert_businessentity()
RETURNS SETOF person.businessentity AS
$$
DECLARE
    _next_id integer;
BEGIN
    SELECT COALESCE(MAX(businessentityid), 0) + 1
    INTO _next_id
    FROM person.businessentity;
    INSERT INTO person.businessentity (businessentityid)
    VALUES (_next_id);
    RETURN QUERY
    SELECT *
    FROM person.businessentity
    WHERE businessentityid = _next_id;
END;
$$
LANGUAGE plpgsql;
SELECT person.insert_businessentity();

SELECT person.insert_businessentity();
CREATE OR REPLACE FUNCTION person.insert_person(
    _persontype character(2),
    _firstname public."Name",
    _lastname public."Name",
    _namestyle boolean DEFAULT false,
    _title character varying(8) DEFAULT NULL,
    _middlename public."Name" DEFAULT NULL,
    _suffix character varying(10) DEFAULT NULL,
    _emailpromotion integer DEFAULT 0,
    _additionalcontactinfo xml DEFAULT NULL,
    _demographics xml DEFAULT NULL,
    _rowguid uuid DEFAULT public.uuid_generate_v1(),
    _modifieddate timestamp DEFAULT now()
)
RETURNS void AS
$$
BEGIN
    INSERT INTO person.person (businessentityid, persontype, namestyle, title, firstname, middlename, lastname, suffix, emailpromotion, additionalcontactinfo, demographics, rowguid, modifieddate)
    VALUES (
        (SELECT COALESCE(MAX(businessentityid), 0) FROM person.businessentity),
        _persontype, _namestyle, _title, _firstname, _middlename, _lastname, _suffix, _emailpromotion, _additionalcontactinfo, _demographics, _rowguid, _modifieddate
    );
END;
$$
LANGUAGE plpgsql;
SELECT person.insert_person('EM','Maria','Silva',FALSE,NULL,'J',NULL,0, 
	NULL,'<IndividualSurvey xmlns="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"><TotalPurchaseYTD>0</TotalPurchaseYTD></IndividualSurvey>',
	'92c4279f-1207-48a3-8448-4636514eb7e2','2009-01-07 00:00:00');
SELECT *FROM person.person ORDER BY businessentityid DESC LIMIT 1;

CREATE OR REPLACE FUNCTION humanresources.insert_employee(
    _businessentityid integer,
    _nationalidnumber character varying,
    _loginid character varying,
    _jobtitle character varying,
    _birthdate date,
    _maritalstatus character,
    _gender character,
    _hiredate date,
    _salariedflag boolean,
    _vacationhours integer,
    _sickleavehours integer,
    _currentflag boolean,
    _rowguid uuid,
    _modifieddate timestamp without time zone,
    _organizationnode character varying
)
RETURNS void AS
$$
BEGIN
    INSERT INTO humanresources.employee (businessentityid, nationalidnumber, loginid, jobtitle, birthdate, maritalstatus, gender, hiredate, salariedflag, vacationhours, sickleavehours, currentflag, rowguid, modifieddate, organizationnode)
    VALUES (_businessentityid, _nationalidnumber, _loginid, _jobtitle, _birthdate, _maritalstatus, _gender, _hiredate, _salariedflag, _vacationhours, _sickleavehours, _currentflag, _rowguid, _modifieddate, _organizationnode);
END;
$$
LANGUAGE plpgsql;

--primeiro parametro deve ser substituido 
SELECT humanresources.insert_employee(20788,  '295847284', 'adventure-works\ken0', 'Chief Executive Officer',
	'1969-01-29', 'S', 'M',  '2009-01-14', TRUE,99,  69, TRUE, 'f01251e5-96a3-448d-981e-0f99d789110d',
	'2014-06-30 00:00:00','/');

SELECT *FROM humanresources.employee ORDER BY businessentityid DESC LIMIT 1;


CREATE OR REPLACE FUNCTION production.insert_product(
    name_var public."Name",
    productnumber_var character varying,
    makeflag_var boolean,
    finishedgoodsflag_var boolean,
    color_var character varying,
    safetystocklevel_var integer,
    reorderpoint_var integer,
    standardcost_var numeric,
    listprice_var numeric,
    size_var character varying,
    sizeunitmeasurecode_var character varying,
    weightunitmeasurecode_var character varying,
    weight_var numeric,
    daystomanufacture_var integer,
    productline_var character varying,
    class_var character varying,
    style_var character varying,
    productsubcategoryid_var integer,
    productmodelid_var integer,
    sellstartdate_var timestamp without time zone,
    sellenddate_var timestamp without time zone,
    discontinueddate_var timestamp without time zone,
    rowguid_var uuid,
    modifieddate_var timestamp without time zone
) RETURNS void AS
$$
DECLARE
    max_product_id integer;
    next_product_id integer;
BEGIN
    SELECT COALESCE(MAX(productid), 0) INTO max_product_id FROM production.product;
    SELECT NEXTVAL('production.product_productid_seq') INTO next_product_id;
    IF next_product_id <= max_product_id THEN
        next_product_id := max_product_id + 1;
    END IF;
    INSERT INTO production.product (
        productid, name, productnumber, makeflag, finishedgoodsflag, color, safetystocklevel,
        reorderpoint, standardcost, listprice, size, sizeunitmeasurecode,
        weightunitmeasurecode, weight, daystomanufacture, productline, class,
        style, productsubcategoryid, productmodelid, sellstartdate, sellenddate,
        discontinueddate, rowguid, modifieddate
    ) VALUES (
        next_product_id, name_var, productnumber_var, makeflag_var, finishedgoodsflag_var, color_var, safetystocklevel_var,
        reorderpoint_var, standardcost_var, listprice_var, size_var, sizeunitmeasurecode_var,
        weightunitmeasurecode_var, weight_var, daystomanufacture_var, productline_var, class_var,
        style_var, productsubcategoryid_var, productmodelid_var, sellstartdate_var, sellenddate_var,
        discontinueddate_var, rowguid_var, modifieddate_var
    );
END;
$$ LANGUAGE plpgsql;


-- Exemplo de inserção de um registro na tabela product
-- Exemplo de inserção de um registro na tabela product
SELECT production.insert_product(
    'Adjustable Race', -- name_var
    'AR-5381', -- productnumber_var
    false, -- makeflag_var
    false, -- finishedgoodsflag_var
    NULL, -- color_var
    1000, -- safetystocklevel_var
    750, -- reorderpoint_var
    0, -- standardcost_var
    0, -- listprice_var
    NULL, -- size_var
    NULL, -- sizeunitmeasurecode_var
    NULL, -- weightunitmeasurecode_var
    NULL, -- weight_var
    0, -- daystomanufacture_var
    NULL, -- productline_var
    NULL, -- class_var
    NULL, -- style_var
    NULL, -- productsubcategoryid_var
    NULL, -- productmodelid_var
    '2008-04-30 00:00:00'::timestamp, -- sellstartdate_var
    NULL, -- sellenddate_var
    NULL, -- discontinueddate_var
    '694215b7-08f7-4c0d-acb1-d734ba44c0c8'::uuid, -- rowguid_var
    '2014-02-08 10:01:36.827'::timestamp -- modifieddate_var
);

SELECT * FROM production.product ORDER BY productid DESC LIMIT 1;
