program apoe.aleo;

struct Product:
    id as field;
    quantity as u64;
    owner_address as address;
    status as boolean;

record ProductRecord:
    owner as address.private;
    id as field.private;
    quantity as u64.private;


mapping products:
	key as field.public;
	value as Product.public;




function create_product:
    input r0 as u64.private;
    hash.bhp256 self.caller into r1 as field;
    cast self.caller r1 r0 into r2 as ProductRecord.record;
    async create_product r1 r0 self.caller into r3;
    output r2 as ProductRecord.record;
    output r3 as apoe.aleo/create_product.future;

finalize create_product:
    input r0 as field.public;
    input r1 as u64.public;
    input r2 as address.public;
    cast r0 r1 r2 false into r3 as Product;
    contains products[r0] into r4;
    assert.eq r4 false;
    set r3 into products[r0];




function transfer_ownership:
    input r0 as field.private;
    input r1 as address.private;
    async transfer_ownership r0 r1 into r2;
    output r0 as field.private;
    output r2 as apoe.aleo/transfer_ownership.future;

finalize transfer_ownership:
    input r0 as field.public;
    input r1 as address.public;
    contains products[r0] into r2;
    assert.eq r2 true;
    get products[r0] into r3;
    assert.eq r3.owner_address self.caller;
    cast r0 r3.quantity r1 false into r4 as Product;
    set r4 into products[r0];




function verify_product:
    input r0 as field.private;
    input r1 as address.private;
    async verify_product r0 r1 into r2;
    output true as boolean.private;
    output r2 as apoe.aleo/verify_product.future;

finalize verify_product:
    input r0 as field.public;
    input r1 as address.public;
    get products[r0] into r2;
    assert.eq r2.owner_address r1;




function view_product_status:
    input r0 as field.private;
    async view_product_status r0 into r1;
    output true as boolean.private;
    output r1 as apoe.aleo/view_product_status.future;

finalize view_product_status:
    input r0 as field.public;
    contains products[r0] into r1;
    assert.eq r1 true;
    get products[r0] into r2;
    cast r0 r2.quantity r2.owner_address true into r3 as Product;
    set r3 into products[r0];

