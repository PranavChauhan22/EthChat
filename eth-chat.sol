pragma solidity ^0.4.17;
pragma experimental ABIEncoderV2;

contract EthChat{
    struct Request{
        string name;
        string email;
        address ethaddress;
        string desc;
        uint followers;
        uint posts;
        uint following;
        string[] posts_collection;
    }
    
    struct Post{
        string caption;
        string pic;
        address ethaddress;
        uint like;
        string[] comments;
        string[] comment_giver;
        
        
    }
    struct story{
        string header;
        string pic;
        string content;
    }
   
    Post[] public postdata;
     story[] public storydata;
      
    address[] public logged_users;

            string[] public newarr;
            mapping(address=>Request) public account_access;
            mapping(address=>bool) public checkin;
            

    function createAccount(string name,string email) public{
      
        Request memory request = Request ({
            name:name,
            email:email,
            ethaddress:msg.sender,
            desc:"",
            following:0,
            followers:0,
            posts:0,
            posts_collection:newarr
        });
        account_access[msg.sender]=request;
      checkin[msg.sender]=true;
      logged_users.push(msg.sender);
   
        
    }
    
    function postCreation(string caption,string pic) public payable{
       require(checkin[msg.sender]);
        require(msg.value > 0.5 ether );
        Post memory post = Post ({
            caption:caption,
            pic:pic,
            ethaddress:msg.sender,
            like:0,
            comments:newarr,
            comment_giver:newarr
            
            });
        account_access[msg.sender].posts=account_access[msg.sender].posts+1;
        account_access[msg.sender].posts_collection.push(pic);
            postdata.push(post);
   
    
    }
    
    function like(uint idx) public payable{
    require(checkin[msg.sender]);
        require(msg.value > 0.2 ether);
        Post storage post=postdata[idx];
        post.like=post.like+1;
        
    }
    function comment(uint idx,string com) public payable{
             require(checkin[msg.sender]);
        require(msg.value > 0.4 ether);
        Post storage post=postdata[idx];
        post.comments.push(com);
        post.comment_giver.push(account_access[msg.sender].name);
       
        
    }
    function story_maker(string header,string pic,string content) public payable{
             require(checkin[msg.sender]);
        require(msg.value > 0.3 ether);
        story memory st=story({
            header:header,
            pic:pic,
            content:content
        });
     
        storydata.push(st);
    }
    function edit_desc(string desc_content) public{
            require(checkin[msg.sender]);
            account_access[msg.sender].desc=desc_content;
    }
    function follow(address who_will_be_followed) public payable{
            require(checkin[msg.sender]);
            require(msg.value > 0.1 ether );
            account_access[who_will_be_followed].followers=account_access[who_will_be_followed].followers+1;
            account_access[msg.sender].following = account_access[msg.sender].following+1;
    }
    
    function getAcc_name() public view returns(string){
        return account_access[msg.sender].name;

    }
    function getAcc_email() public view returns(string){
        return account_access[msg.sender].email;

    }
    function getAcc_desc() public view returns(string){
        return account_access[msg.sender].desc;

    }
    function getAcc_followers() public view returns(uint){
        return account_access[msg.sender].followers;

    }
    function getAcc_posts() public view returns(uint){
        return account_access[msg.sender].posts;

    }
    function getAcc_following() public view returns(uint){
        return account_access[msg.sender].following;

    }
       function getAcc_post_collections() public view returns(string[]){
        return account_access[msg.sender].posts_collection;

    }
    function get_users() public view returns(address[]){
        return logged_users;
    }
    function get_posts_len() public view returns(uint){
        return postdata.length;
    }
     function get_stories_len() public view returns(uint){
        return storydata.length;
    }
    function get_posts_caption(uint id) public view returns(string){
        return postdata[id].caption;
    }
    function get_posts_address(uint id) public view returns(address){
        return postdata[id].ethaddress;
    }
    function get_posts_pic(uint id) public view returns(string){
        return postdata[id].pic;
    }
    function get_posts_like(uint id) public view returns(uint){
        return postdata[id].like;
    }
    function get_posts_comments(uint id) public view returns(string[]){
        return postdata[id].comments;
    }
    function get_posts_comment_giver(uint id) public view returns(string[]){
        return postdata[id].comment_giver;
    }
    function get_story_header(uint id) public view returns(string){
        return storydata[id].header;
    }
    
    function get_story_pic(uint id) public view returns(string){
        return storydata[id].pic;
    }
    
    function get_story_content(uint id) public view returns(string){
        return storydata[id].content;
    }
    
    
    
    
}