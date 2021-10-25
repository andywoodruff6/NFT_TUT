module.exports = async ({
    getNamedAccounts,
    deployments,
    getChainId
}) => {
    const { deploy, log } = deployments;
    const {deployer} = await getNamedAccounts();
    const chainId = await getChainId();

    log("------------------------------")
    const SVGNFT = await deploy("SVGNFT", { 
        from: deployer, 
        log: true }
    );
    log(`You have deployed an NFT contract to ${SVGNFT.address}`);
}