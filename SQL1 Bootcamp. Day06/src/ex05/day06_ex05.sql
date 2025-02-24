COMMENT ON TABLE person_discounts IS 'Table for storing information about personalized discounts for customers at various pizzerias.';
COMMENT ON COLUMN person_discounts.id IS 'Unique identifier for the personalized discount record.';
COMMENT ON COLUMN person_discounts.person_id IS 'Identifier of the customer (linked to the person table) who recieves the discount';
COMMENT ON COLUMN person_discounts.pizzeria_id IS 'Identifier of the pizzeria (linked to the pizzeria table) where the customer receives the discount.';
COMMENT ON COLUMN person_discounts.discount IS 'The discount value in percentage offered to the customer at this pizzeria. The value can range from 0 to 100 percent.';