program apoe.aleo {
    // Define a struct for Product details
    struct Product {
        id: field,
        quantity: u64,
        owner_address: address,
        status: bool,
    }

    record ProductRecord {
        id: field,
        quantity: u64,
        owner: address,
    }

    // Define a mapping to store product records
    mapping products: field => Product;

    // Transition function to create a new product
    async transition create_product(quantity: u64) -> (ProductRecord, Future) {
        let owner_address: address = get_caller_address(); // Set the caller as the initial owner_address
        let id: field = BHP256::hash_to_field(owner_address); // Generate a unique ID
        let product_record: ProductRecord = ProductRecord { id, quantity, owner: owner_address };
        return (product_record, create(id, quantity, owner_address));
    }

    async function create(id: field, quantity: u64, owner_address: address) {
        let product: Product = Product { id, quantity, owner_address, status:false };
        assert_eq(Mapping::contains(products, id), false); // Ensure the ID is not already in use  
        // let current_product: Product = Mapping::get(products, id);
        Mapping::set(products, id, product);
    }

    inline get_caller_address() -> address {
        let owner_address: address = self.caller; // Set the caller as the initial owner_address
        return owner_address;
    }

    // Transition function to transfer owner_ship of a product
    async transition transfer_ownership(product_id: field, new_owner: address) -> (field, Future) {
        return (product_id, transfer(product_id, new_owner));
    }

    async function transfer(product_id: field, new_owner: address) {
        assert_eq(Mapping::contains(products, product_id), true); // Ensure the ID is already in use  
        let old_product: Product = Mapping::get(products, product_id);
        assert_eq(old_product.owner_address, get_caller_address()); // Ensure the caller is the current owner_address
        let new_product: Product = Product { id: product_id, quantity: old_product.quantity, owner_address: new_owner, status: false };
        Mapping::set(products, product_id, new_product);
    }

    // Function to verify a product's authenticity
    async transition verify_product(product_id: field, addr: address) -> (bool, Future) {
        return (true, verify(product_id, addr));
    }

    async function verify(product_id: field, addr: address) {
        let product: Product = Mapping::get(products, product_id);
        assert_eq(product.owner_address, addr); // Simple verification check
    }

    // Function to view the supply chain status of a product
    async transition view_product_status(product_id: field) -> (bool, Future) {
        return (true, view(product_id)); // Simple status return
    }

    async function view(product_id: field) {
        assert_eq(Mapping::contains(products, product_id), true); // Ensure the ID is already in use
        let product: Product = Mapping::get(products, product_id);
        let view_product: Product = Product { id: product_id, quantity: product.quantity, owner_address: product.owner_address, status: true };
        Mapping::set(products, product_id, view_product);
    }
