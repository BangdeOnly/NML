_G.SetFOV110=function()

    local GameplayData=require("GameLua.GameCore.Data.GameplayData")

    local player=GameplayData.GetPlayerCharacter()

    if not slua.isValid(player) then
        return
    end

    local camera=player.ThirdPersonCameraComponent

    if not camera then
        return
    end

    camera:SetFieldOfView(110)

end

pcall(_G.SetFOV110)

_G.SetNewPhysicsAssetAndGiantHitbox=function()

    local GameplayData=require("GameLua.GameCore.Data.GameplayData")

    local player=GameplayData.GetPlayerCharacter()

    if not slua.isValid(player) then
        _G.WriteLog("[GIANT HITBOX] PLAYER INVALID ✘")
        return
    end

    local success,err=pcall(function()

        local mesh=player.Mesh

        if not mesh then
            _G.WriteLog("[GIANT HITBOX] MESH NIL ✘")
            return
        end

        local skeletalMesh=mesh.SkeletalMesh

        if not skeletalMesh then
            _G.WriteLog("[GIANT HITBOX] SKELETALMESH NIL ✘")
            return
        end

        local beforePhys=skeletalMesh.PhysicsAsset

        _G.WriteLog("[GIANT HITBOX] PHYSICS BEFORE = "..tostring(beforePhys))

        local phys=slua.loadObject("/Game/Arts_Player/Characters/Animation/Base_Skeleton/CH_Base_SK_PhysicsAsset_New.CH_Base_SK_PhysicsAsset_New")

        if not phys then
            _G.WriteLog("[GIANT HITBOX] PHYSICS LOAD FAILED ✘")
            return
        end

        skeletalMesh.PhysicsAsset=phys

        local afterPhys=skeletalMesh.PhysicsAsset

        _G.WriteLog("[GIANT HITBOX] PHYSICS AFTER = "..tostring(afterPhys))

        for _,body in pairs(phys.SkeletalBodySetups or {}) do

            local boneName=tostring(body.BoneName or body.BoneNamePrivate or "")

            if string.find(boneName:lower(),"head") then

                _G.WriteLog("[GIANT HITBOX] HEAD FOUND ✔ = "..boneName)

                local agg=body.AggGeom

                if agg and agg.BoxElems then

                    for _,box in pairs(agg.BoxElems) do

                        box.X=box.X*200
                        box.Y=box.Y*200
                        box.Z=box.Z*200

                        _G.WriteLog(
                            "[GIANT HITBOX] BOX SCALE ✔ X:"
                            ..tostring(box.X)
                            .." Y:"
                            ..tostring(box.Y)
                            .." Z:"
                            ..tostring(box.Z)
                        )

                    end

                end

                if agg and agg.SphereElems then

                    for _,sphere in pairs(agg.SphereElems) do

                        sphere.Radius=sphere.Radius*200

                        _G.WriteLog(
                            "[GIANT HITBOX] SPHERE SCALE ✔ R:"
                            ..tostring(sphere.Radius)
                        )

                    end

                end

                if agg and agg.SphylElems then

                    for _,capsule in pairs(agg.SphylElems) do

                        capsule.Radius=capsule.Radius*200
                        capsule.Length=capsule.Length*200

                        _G.WriteLog(
                            "[GIANT HITBOX] CAPSULE SCALE ✔ R:"
                            ..tostring(capsule.Radius)
                            .." L:"
                            ..tostring(capsule.Length)
                        )

                    end

                end

            end

        end

        _G.WriteLog("[GIANT HITBOX] ENABLED ✔")

    end)

    if not success then
        _G.WriteLog("[GIANT HITBOX ERROR] "..tostring(err))
    end

end

pcall(_G.SetNewPhysicsAssetAndGiantHitbox)

_G.SetMaterialRender=function(DisableDepth,BlendMode)

    local GameplayData=require("GameLua.GameCore.Data.GameplayData")

    local player=GameplayData.GetPlayerCharacter()

    if not slua.isValid(player) then
        _G.WriteLog("[MATERIAL] PLAYER INVALID ✘")
        return
    end

    local success,err=pcall(function()

        local mesh=player.Mesh

        if not mesh then
            _G.WriteLog("[MATERIAL] MESH NIL ✘")
            return
        end

        local matInterface=mesh:GetMaterial(0)

        if not matInterface then
            _G.WriteLog("[MATERIAL] MATERIAL NIL ✘")
            return
        end

        local baseMat=matInterface:GetBaseMaterial()

        if not baseMat then
            _G.WriteLog("[MATERIAL] BASE MATERIAL NIL ✘")
            return
        end

        baseMat.bDisableDepthTest=DisableDepth
        baseMat.BlendMode=BlendMode

        _G.WriteLog(
            "[MATERIAL] APPLIED ✔ DEPTH:"
            ..tostring(DisableDepth)
            .." BLEND:"
            ..tostring(BlendMode)
        )

    end)

    if not success then
        _G.WriteLog("[MATERIAL ERROR] "..tostring(err))
    end

end

pcall(function()
    _G.SetMaterialRender(true,2)
end)