local winSize = CCDirector:sharedDirector():getWinSize()local bulletArray, bulletBatchNode, enemyLayerlocal function movebullet_schedule()    local enemyArray = enemyLayer:getEnemyArray()    local index = 0    local len = bulletArray:count()    local b, y    while index < len do        b = tolua.cast(bulletArray:objectAtIndex(index), "CCSprite")        y = b:getPositionY() + 5        if y > winSize.height then            -- remove the bullet when overflow            bulletArray:removeObject(b)            bulletBatchNode:removeChild(b, true)            len = len - 1        else            local enemyIndex, enemyLen = 0, enemyArray:count()            while enemyIndex < enemyLen do                local enemy = tolua.cast(enemyArray:objectAtIndex(enemyIndex), "CCSprite")                if enemy:boundingBox():intersectsRect(b:boundingBox()) then                                        EnemyLayer:enemyHitten(enemy)                    enemyLen = enemyLen - 1                                    end                enemyIndex = enemyIndex + 1            end            -- move the bullet            b:setPositionY(y)            index = index + 1       end    endendlocal function init(layer)    -- load the plist    CCSpriteFrameCache:sharedSpriteFrameCache():addSpriteFramesWithFile(PlayerBulletLayer_Bullet_plist, PlayerBulletLayer_Bullet);        -- load bullet    bulletBatchNode = CCSpriteBatchNode:create(PlayerBulletLayer_Bullet)        -- load blend    local blend = ccBlendFunc()    blend.src = GL_SRC_ALPHA    blend.dst = GL_ONE    bulletBatchNode:setBlendFunc(blend)        -- init bullet array    bulletArray = CCArray:create()    bulletArray:retain()        layer:addChild(bulletBatchNode)        CCDirector:sharedDirector():getScheduler():scheduleScriptFunc(movebullet_schedule, 0.01, false)    endPlayerBulletLayer = {}function PlayerBulletLayer:create()    local layer = CCLayer:create()        init(layer)        return layerendfunction PlayerBulletLayer:addNewBullet(x, y)    local bulletL = CCSprite:createWithSpriteFrameName(PlayerBulletLayer_Bullet_Frame)    bulletL:setPosition(x - 12, y + 18)    bulletArray:addObject(bulletL)    bulletBatchNode:addChild(bulletL)        local bulletR = CCSprite:createWithSpriteFrameName(PlayerBulletLayer_Bullet_Frame)    bulletR:setPosition(x + 12, y + 18)    bulletArray:addObject(bulletR)    bulletBatchNode:addChild(bulletR)endfunction PlayerBulletLayer:setEnemyLayer(layer)    enemyLayer = layerend